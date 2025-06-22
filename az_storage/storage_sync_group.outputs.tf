output "storage_sync_groups" {
    value = {
    for k, value in azurerm_storage_sync_group.storage_sync_groups : k => {
      id       = value.id
      name     = value.name
    }
  }
  
}