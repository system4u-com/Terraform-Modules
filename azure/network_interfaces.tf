resource "azurerm_network_interface" "network_interfaces" {
  for_each = var.network_interfaces

  name                = each.key
  location            = each.value.resource_group.location
  resource_group_name = each.value.resource_group.name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                          = ip_configuration.key
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address            = ip_configuration.value.private_ip_address
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
    }
  }
  
  tags = each.value.tags
  
}