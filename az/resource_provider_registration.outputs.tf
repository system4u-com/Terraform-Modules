output "registered_resource_providers" {
  value = {
    for k, value in azurerm_resource_provider_registration.resource_provider_registrations : k => {
      name     = coalesce(k,value.name)
    }
  }
}