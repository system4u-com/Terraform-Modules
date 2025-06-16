# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "avd_application_groups" {
  for_each = var.application_groups

  resource_group_name      = each.value.resource_group.name
  location                 = coalesce(each.value.location, each.value.resource_group.location)
  name                     = coalesce(each.value.name, each.key)

  host_pool_id        = each.value.host_pool_id
  type                = each.value.type
  friendly_name       = each.value.friendly_name
  default_desktop_display_name = coalesce(each.value.default_desktop_display_name, each.value.friendly_name, each.key)
  description         = each.value.description
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "avd_workspace_application_group_associations" {
  for_each = var.workspace_application_group_associations

  application_group_id = each.value.application_group_id
  workspace_id         = each.value.workspace_id
}