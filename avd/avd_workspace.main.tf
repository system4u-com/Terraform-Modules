resource "azurerm_virtual_desktop_workspace" "avd_workspaces" {
  for_each = var.workspaces

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location)
  resource_group_name = each.value.resource_group.name

  friendly_name = each.value.friendly_name
  description   = each.value.description
  tags          = merge(var.default_tags, each.value.tags)
}
