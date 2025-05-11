resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups

  name     = each.key
  # location = coalesce(each.value.location, var.default_location)
  location = each.value.location
  tags     = each.value.tags
}
