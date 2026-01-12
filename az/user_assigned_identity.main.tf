resource "azurerm_user_assigned_identity" "user_assigned_identities" {
  for_each = var.user_assigned_identities

  name     = coalesce(each.value.name, each.key)
  location = coalesce(each.value.location, each.value.resource_group.location)
  resource_group_name = each.value.resource_group.name
  tags     = each.value.tags
}