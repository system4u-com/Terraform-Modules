output "windows_function_apps" {
  value = {
    for k, value in azurerm_windows_function_app.windows_function_apps : k => {
      id       = value.id
      name     = value.name
      location = value.location
      identity = length(value.identity) > 0 ? {
        principal_id = value.identity[0].principal_id
        tenant_id    = value.identity[0].tenant_id
        type         = value.identity[0].type
      } : null
    }
  }
}