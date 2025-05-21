output "virtual_networks" {
  value = {
    for k, value in azurerm_virtual_network.virtual_networks : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "subnets" {
  value = {
    for k, value in azurerm_subnet.subnets : k => {
      id                   = value.id
      name                 = value.name
      resource_group_name  = value.resource_group_name
      virtual_network_name = value.virtual_network_name
    }
  }
}

output "express_route_circuits" {
  value = {
    for k, value in azurerm_express_route_circuit.express_route_circuits : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "network_interfaces" {
  value = {
    for k, value in azurerm_network_interface.network_interfaces : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "public_ips" {
  value = {
    for k, value in azurerm_public_ip.public_ips : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

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


