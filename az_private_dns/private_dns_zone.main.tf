resource "azurerm_private_dns_zone" "private_dns_zones" {
  for_each = var.private_dns_zones

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  tags                = each.value.tags
}

data "azurerm_private_dns_zone" "unmanaged_private_dns_zones" {
  for_each = var.unmanaged_private_dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

locals {
  private_dns_zones = merge(
    {
      for k, value in azurerm_private_dns_zone.private_dns_zones : k => {
        id                  = value.id
        name                = value.name
        resource_group_name = value.resource_group_name
      }
    },
    {
      for k, value in data.azurerm_private_dns_zone.unmanaged_private_dns_zones : k => {
        id                  = value.id
        name                = value.name
        resource_group_name = value.resource_group_name
      }
    }
  )
}
