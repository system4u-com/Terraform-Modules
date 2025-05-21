resource "azurerm_marketplace_agreement" "marketplace_agreements" {
  for_each = var.marketplace_agreements

  publisher = each.value.publisher
  offer     = each.value.offer
  plan      = each.value.plan
}