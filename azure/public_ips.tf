resource "azurerm_public_ip" "public_ips" {
  for_each = var.public_ips

  name                = each.key
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  sku                 = each.value.sku
  allocation_method   = each.value.allocation_method
  domain_name_label   = each.value.domain_name_label
  tags                = each.value.tags
}
