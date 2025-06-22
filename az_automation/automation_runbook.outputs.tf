output "automation_runbooks" {
  value = {
    for k, value in azurerm_automation_runbook.automation_runbooks : k => {
      id       = value.id
      name     = value.name
      location = value.location
      automation_account_name = value.automation_account_name
      log_verbose = value.log_verbose
      log_progress = value.log_progress
      description = value.description
      runbook_type = value.runbook_type
      tags     = value.tags
    }
  }
}