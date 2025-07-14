resource "azurerm_virtual_machine" "virtual_machines" {
  for_each = var.virtual_machines

  resource_group_name = each.value.resource_group.name
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  name                = coalesce(each.value.name, each.key)                               // Use the key as the name if not specified

  vm_size                      = each.value.vm_size
  primary_network_interface_id = each.value.primary_network_interface_id
  network_interface_ids        = each.value.network_interface_ids

  dynamic "os_profile" {
    for_each = each.value.os_profile != null ? [each.value.os_profile] : []
    content {
      computer_name  = coalesce(each.value.os_profile.computer_name, each.key) // Use the key as the computer name if not specified
      admin_username = each.value.os_profile.admin_username
      admin_password = each.value.os_profile.admin_password
      custom_data    = each.value.os_profile.custom_data
    }
  }

  storage_os_disk {
    name          = coalesce(each.value.storage_os_disk.name,"${each.key}-osdisk")
    caching       = each.value.storage_os_disk.caching
    os_type       = each.value.storage_os_disk.os_type
    disk_size_gb  = each.value.storage_os_disk.disk_size_gb
    create_option = each.value.storage_os_disk.create_option
  }

  # source_image_reference {
  #   publisher = each.value.source_image_reference.publisher
  #   offer     = each.value.source_image_reference.offer
  #   sku       = each.value.source_image_reference.sku
  #   version   = each.value.source_image_reference.version
  # }

  dynamic "plan" {
    for_each = each.value.plan != null ? [each.value.plan] : []

    content {
      name      = plan.value.name
      publisher = plan.value.publisher
      product   = plan.value.product
    }
  }

  dynamic "boot_diagnostics" {
    for_each = each.value.boot_diagnostics != null ? [each.value.boot_diagnostics] : []
    content {
      enabled     = boot_diagnostics.value.enabled
      storage_uri = boot_diagnostics.value.storage_uri
    }
    
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  license_type = each.value.license_type

  tags = each.value.tags
}
