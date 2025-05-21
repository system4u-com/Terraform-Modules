output "network_peerings" {
  value = {
    for k, value in azurerm_virtual_network_peering.peerings : k => {
      id                        = value.id
      name                      = value.name
      resource_group_name       = value.resource_group_name
      virtual_network_name      = value.virtual_network_name
      remote_virtual_network_id = value.remote_virtual_network_id
    }
  }
}