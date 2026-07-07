resource "azurerm_application_insights" "application_insights" {
  for_each = var.application_insights

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location)
  resource_group_name = each.value.resource_group.name
  application_type    = each.value.application_type
  workspace_id        = each.value.workspace_id
  retention_in_days   = each.value.retention_in_days
  tags                = each.value.tags
}