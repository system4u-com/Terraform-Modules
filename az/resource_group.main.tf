resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups

  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}

data "azurerm_resource_group" "unmanaged_resource_groups" {
  for_each = toset(var.unmanaged_resource_groups)

  name = each.key
}