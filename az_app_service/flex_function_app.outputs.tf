output "flex_function_apps" {
  value = {
    for k, value in azurerm_function_app.flex_function_apps : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}