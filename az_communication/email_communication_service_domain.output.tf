output "email_communication_service_domains" {
    value = {
        for k, value in azurerm_email_communication_service_domain.email_communication_service_domains : k => {
            id       = value.id
            name     = value.name
        }
    }
}