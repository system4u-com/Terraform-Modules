resource "azurerm_storage_sync" "storage_syncs" {
  for_each = var.storage_syncs

  name                    = coalesce(each.value.name, each.key)
  resource_group_name     = each.value.resource_group.name
  location                = coalesce(each.value.location, each.value.resource_group.location)
  incoming_traffic_policy = each.value.incoming_traffic_policy // Default is AllowAllTraffic
  tags                    = each.value.tags
}
