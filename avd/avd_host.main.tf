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
