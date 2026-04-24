output "application_insights" {
  value = {
    for k, value in azurerm_application_insights.application_insights : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      app_id              = value.app_id
      instrumentation_key = value.instrumentation_key
      connection_string   = value.connection_string
    }
  }
}