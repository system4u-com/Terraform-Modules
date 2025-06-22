resource "azurerm_storage_sync_group" "storage_sync_groups" {
  for_each = var.storage_sync_groups

  name                    = coalesce(each.value.name, each.key)
  storage_sync_id        = each.value.storage_sync.id
}
