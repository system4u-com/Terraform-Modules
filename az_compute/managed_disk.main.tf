resource "azurerm_managed_disk" "managed_disks" {
  for_each = var.managed_disks

  name                 = coalesce(each.value.name, each.key)
  location             = coalesce(each.value.location, each.value.resource_group.location)
  resource_group_name  = each.value.resource_group.name
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
  tags                 = each.value.tags
}

#Attach data disks to linux VMs
resource "azurerm_virtual_machine_data_disk_attachment" "vm_data_disk_attachments" {
  for_each = var.vm_data_disks_attachments

  managed_disk_id    = each.value.managed_disk_id
  virtual_machine_id = each.value.virtual_machine_id
  lun                = each.value.lun
  caching            = each.value.caching
  create_option      = each.value.create_option
}
