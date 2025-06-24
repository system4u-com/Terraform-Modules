output "application_gateways" {
  value = {
    for k, value in azurerm_application_gateway.application_gateways : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

