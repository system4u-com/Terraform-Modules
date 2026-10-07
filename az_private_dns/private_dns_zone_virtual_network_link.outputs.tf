output "private_dns_zone_virtual_network_links" {
  value = {
    for k, value in azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_links : k => {
      id                   = value.id
      name                 = value.name
      private_dns_zone_id  = value.private_dns_zone_id
      virtual_network_id   = value.virtual_network_id
      registration_enabled = value.registration_enabled
    }
  }
}
