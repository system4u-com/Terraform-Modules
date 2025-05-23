resource "azurerm_virtual_desktop_host_pool" "avd_host_pools" {
  for_each = var.host_pools

  resource_group_name      = each.value.resource_group.name
  location                 = coalesce(each.value.location, each.value.resource_group.location)
  name                     = coalesce(each.value.name, each.key)
  friendly_name            = each.value.friendly_name
  description              = each.value.description
  validate_environment     = each.value.validate_environment
  start_vm_on_connect      = each.value.start_vm_on_connect
  custom_rdp_properties    = each.value.custom_rdp_properties
  type                     = each.value.type
  maximum_sessions_allowed = each.value.maximum_sessions_allowed
  load_balancer_type       = each.value.load_balancer_type
  tags                     = merge(var.default_tags, each.value.tags)
}
