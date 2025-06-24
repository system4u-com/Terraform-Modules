resource "azurerm_key_vault" "key_vaults" {
  for_each = var.key_vaults

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  location            = coalesce(each.value.location, each.value.resource_group.location)
  tenant_id = each.value.tenant_id
  sku_name = each.value.sku_name
  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled
  enable_rbac_authorization = each.value.enable_rbac_authorization
  tags = each.value.tags
}
