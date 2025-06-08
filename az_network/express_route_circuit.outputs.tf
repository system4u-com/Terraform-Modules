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

