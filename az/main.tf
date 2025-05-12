resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups

  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}

resource "azurerm_marketplace_agreement" "marketplace_agreements" {
  for_each = var.marketplace_agreements

  publisher = each.value.publisher
  offer     = each.value.offer
  plan      = each.value.plan
}
