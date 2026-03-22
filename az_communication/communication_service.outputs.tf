output "communication_services" {
    value = {
        for k, value in azurerm_communication_service.communication_services : k => {
            id       = value.id
            name     = value.name
            data_location = value.data_location
        }
    }
  
}