output "automation_accounts" {
  value = {
    for k, value in azurerm_automation_account.automation_accounts : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
  
}