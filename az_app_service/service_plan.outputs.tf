output service_plans {
  value = {
    for k, value in azurerm_service_plan.service_plans : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}
