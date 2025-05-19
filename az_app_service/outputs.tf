output linux_function_apps {
  value = {
    for k, value in azurerm_linux_function_app.linux_function_apps : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}