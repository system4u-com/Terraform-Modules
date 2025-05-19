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

  dynamic "plan" {
    for_each = each.value.plan != null ? [each.value.plan] : []

    content {
      name      = plan.value.name
      publisher = plan.value.publisher
      product   = plan.value.product
    }
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

  dynamic "plan" {
    for_each = each.value.plan != null ? [each.value.plan] : []

    content {
      name      = plan.value.name
      publisher = plan.value.publisher
      product   = plan.value.product
    }
  }

  tags = each.value.tags
}


resource "azurerm_managed_disk" "data_disks" {
  for_each = {
    for item in flatten([
      for vm_name, vm_data in var.data_disks : [
        for idx, disk in vm_data.disks : {
          key                 = "${vm_name}-${disk.name}"
          vm_name             = vm_name
          disk                = disk
          resource_group_name = vm_data.resource_group_name
          location            = vm_data.location
          lun                 = idx
        }
      ]
    ]) : item.key => item
  }

  name                 = each.value.disk.name
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  storage_account_type = each.value.disk.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk.size_gb
}

#Attach data disks to linux VMs
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachments" {
  for_each = azurerm_managed_disk.data_disks
  managed_disk_id    = each.value.id
  virtual_machine_id = azurerm_linux_virtual_machine[each.value.vm_name].id
  lun                = each.value.lun
  caching            = each.value.disk.caching
}