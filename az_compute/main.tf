resource "azurerm_windows_virtual_machine" "windows_vms" {
  for_each = var.windows_virtual_machines

  name                  = each.key
  resource_group_name   = each.value.resource_group.name
  location              = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = each.value.network_interface_ids

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  plan {
    name      = each.value.plan.name
    publisher = each.value.plan.publisher
    product   = each.value.plan.product
  }

  license_type = each.value.license_type

  tags = each.value.tags
}

resource "azurerm_linux_virtual_machine" "linux_vms" {
  for_each = var.linux_virtual_machines

  name                            = each.key
  resource_group_name             = each.value.resource_group.name
  location                        = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = each.value.network_interface_ids

  dynamic "admin_ssh_key" {
    for_each = each.value.admin_ssh_keys

    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  plan {
    name      = each.value.plan.name
    publisher = each.value.plan.publisher
    product   = each.value.plan.product
  }

  tags = each.value.tags
}
