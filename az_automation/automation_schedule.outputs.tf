output "automation_schedules" {
  value = {
    for k, value in azurerm_automation_schedule.automation_schedules : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
  
}