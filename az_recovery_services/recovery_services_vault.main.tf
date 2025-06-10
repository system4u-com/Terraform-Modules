resource "azurerm_recovery_services_vault" "recovery_services_vaults" {
  for_each = var.recovery_services_vaults
  
  name                = coalesce(each.value.name, each.key)                               // Use the key as the name if not specified
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name

  sku               = each.value.sku
  storage_mode_type = each.value.storage_mode_type
  immutability      = each.value.immutability
  tags              = merge(var.default_tags, each.value.tags)
}