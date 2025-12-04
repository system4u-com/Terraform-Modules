resource "azurerm_storage_account" "storage_accounts" {
  for_each = var.storage_accounts

  name                       = coalesce(each.value.name, each.key)
  resource_group_name        = each.value.resource_group.name
  location                   = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  account_tier               = each.value.account_tier
  account_kind               = each.value.account_kind
  account_replication_type   = each.value.account_replication_type
  access_tier                = each.value.access_tier
  https_traffic_only_enabled = each.value.https_traffic_only_enabled
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public

 # IMPORTANT: enable azure files identity auth -> AADKERB
  azure_files_authentication {
    directory_type = "AADKERB"
    # When directory_type == "AADKERB", active_directory block must NOT be provided.
  }

  tags = each.value.tags

  dynamic "network_rules" {
    for_each = each.value.network_rules != null ? [each.value.network_rules] : []

    content {
      bypass                     = network_rules.value.bypass
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnets != null ? [for subnet in network_rules.value.virtual_network_subnets : subnet.id] : [] // Convert the list of objects to a list of strings
    }
  }
}
