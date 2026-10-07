resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_links" {
  for_each = var.private_dns_zone_virtual_network_links

  name                 = coalesce(each.value.name, each.key)
  private_dns_zone_id  = local.private_dns_zones[each.value.zone_key].id
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled
  tags                 = each.value.tags
}
