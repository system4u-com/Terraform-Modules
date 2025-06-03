variable "service_plans" {
  description = "App Service Plans"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string) // Location of the App Service Plan, if not specified, it will use the location of the resource group
    os_type  = optional(string, "Linux")
    sku_name = optional(string, "Y1")
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "automation_accounts" {
  description = "Azure Automation Accounts"
  type = map(object({
    name                = optional(string)
    resource_group      = object({
      id       = string
      name     = string
      location = string
    })
    location            = optional(string) // Location of the Automation Account, if not specified, it will use the location of the resource group
    sku_name            = optional(string, "Basic")
    tags                = optional(map(string), {})
    monitoring          = optional(object({
      enabled                    = optional(bool, true)
      log_analytics_workspace_id = optional(string)
      log_category               = optional(string)
      log_category_group         = optional(string)
      metrics_enabled            = optional(bool, true)
      metrics                    = optional(string)
    }), {})
  }))
  default = {}
  
}