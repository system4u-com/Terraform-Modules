variable "automation_runbooks" {
  description = "Azure Automation Runbooks"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location                = optional(string)               // Location of the Automation Account, if not specified, it will use the location of the resource group
    automation_account_name = string                         // Name of the Automation Account
    log_verbose             = optional(bool, false)          // Enable verbose logging for the runbook
    log_progress            = optional(bool, false)          // Enable progress logging for the runbook
    description             = optional(string)               // Description of the runbook
    runbook_type            = optional(string, "PowerShell") // Type of the runbook, e.g., "PowerShell", "Python2", "Python3", "Graph"
    tags                    = optional(map(string), {})
  }))
  default = {}

}
