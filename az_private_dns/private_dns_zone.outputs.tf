output "private_dns_zones" {
  value = {
    for k, value in azurerm_private_dns_zone.private_dns_zones : k => {
      id                  = value.id
      name                = value.name
      resource_group_name = value.resource_group_name
    }
  }
}

output "unmanaged_private_dns_zones" {
  value = {
    for k, value in data.azurerm_private_dns_zone.unmanaged_private_dns_zones : k => {
      id                  = value.id
      name                = value.name
      resource_group_name = value.resource_group_name
    }
  }
}
