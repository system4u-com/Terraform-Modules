locals {
  avd_hosts_flattened = flatten([
    for host in var.hosts : [
      for i in range(host.host_count) : {
        name                = "${host.name_preffix}${format(var.name_suffix_format, i + 1)}"
        resource_group_name = host.resource_group.name
        location            = coalesce(host.location, host.resource_group.location)
        size                = host.size
        admin_username      = host.admin_username
        admin_password      = host.admin_password
        subnet_id           = host.subnet_id
        os_disk             = host.os_disk
        source_image_reference = {
          publisher = host.source_image_reference.publisher
          offer     = host.source_image_reference.offer
          sku       = host.source_image_reference.sku
          version   = coalesce(host.source_image_reference.version, "latest")
        }
        license_type = coalesce(host.license_type, "Windows_Client")
        domain_join_type = host.domain_join_type
        host_pool_name = host.host_pool_name
        tags         = host.tags
      }
    ]
  ])
}

resource "azurerm_network_interface" "avd_network_interfaces" {
  for_each = { for host in local.avd_hosts_flattened : host.name => host }

  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags                = merge(var.default_tags, each.value.tags)
  name                = "${each.value.name}-nic1"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "avd_hosts" {
  for_each = { for host in local.avd_hosts_flattened : host.name => host }

  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  tags                  = merge(var.default_tags, each.value.tags)
  name                  = each.value.name
  size                  = each.value.size
  license_type          = each.value.license_type
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.avd_network_interfaces[each.key].id]
  provision_vm_agent = true

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = coalesce(each.value.source_image_reference.version, "latest")
  }
}

resource "azurerm_virtual_machine_extension" "avd_host_extensions" {
  for_each = { for host in local.avd_hosts_flattened : host.name => host if host.domain_join_type == "entra-join" ? true : false}

  name                 = "${azurerm_windows_virtual_machine.avd_hosts[each.key].name}-entra-join"
  virtual_machine_id   = azurerm_windows_virtual_machine.avd_hosts[each.key].id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "2.2"
  auto_upgrade_minor_version = true
}

### Conditional deployment of Azure Active Directory Domain Services join
# resource "azurerm_virtual_machine_extension" "avd_host_extensions" {
#   for_each = { for host in local.avd_hosts_flattened : k => v if host.domain_join_type == "ad-join" ? true : false }

#   name                       = "${azurerm_windows_virtual_machine.avd-session-hosts[each.key].name}-adds-join"
#   virtual_machine_id         = azurerm_windows_virtual_machine.avd_hosts[each.key].id
#   publisher                  = "Microsoft.Compute"
#   type                       = "JsonADDomainExtension"
#   type_handler_version       = "1.3"
#   auto_upgrade_minor_version = true
#   tags                       = azurerm_windows_virtual_machine.avd_hosts[each.key].tags

#   settings = <<-SETTINGS
#     {
#       "Name": "${each.value.aadds_domain_name}",
#       "OUPath": "${each.value.aadds_avd_ou_path}",
#       "User": "${each.value.azuread_user_dc_admin_upn}",
#       "Restart": "true",
#       "Options": "3"
#     }
#     SETTINGS

#   protected_settings = <<-PROTECTED_SETTINGS
#     {
#       "Password": "${each.value.azuread_user_dc_admin_password}"
#     }
#     PROTECTED_SETTINGS

#   lifecycle {
#     ignore_changes = [settings, protected_settings]
#   }
# }


resource "azurerm_virtual_machine_extension" "avd_host_registrations" {
  for_each = { for host in local.avd_hosts_flattened : host.name => host if host.host_pool_name != null && host.host_pool_name != "" }

  name                 = "${azurerm_windows_virtual_machine.avd_hosts[each.key].name}-host-registration"
  virtual_machine_id   = azurerm_windows_virtual_machine.avd_hosts[each.key].id
  publisher            = "Microsoft.Powershell"
  type                 = "DSC"
  type_handler_version = "2.83"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "hostPoolName": "${azurerm_virtual_desktop_host_pool.avd_host_pools[each.value.host_pool_name].name}",
        "aadJoin": false
      }
    }
    SETTINGS

  protected_settings = <<-PROTECTED_SETTINGS
    {
      "properties": {
        "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.avd_host_pool_registration_info[each.value.host_pool_name].token}"
      }
    }
    PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }

}