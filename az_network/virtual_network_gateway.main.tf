resource "azurerm_virtual_network_gateway" "virtual_network_gateways" {
  for_each = var.virtual_network_gateways

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  type                = each.value.type
  sku                 = each.value.sku

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                          = ip_configuration.key
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = ip_configuration.value.subnet_id
    }
  }
}
