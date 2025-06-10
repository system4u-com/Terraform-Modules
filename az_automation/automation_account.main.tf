resource "azurerm_automation_account" "automation_accounts" {
  for_each = var.automation_accounts

  name                = coalesce(each.value.name, each.key)
  location = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  sku_name            = each.value.sku_name
  tags                = each.value.tags
  identity {
    type         = each.value.identity.type
    identity_ids = each.value.identity.identity_ids
  }
}