output "email_communication_services" {
    value = {
        for k, value in azurerm_email_communication_service.email_communication_services : k => {
            id       = value.id
            name     = value.name
            data_location = value.data_location
        }
    }
  
}