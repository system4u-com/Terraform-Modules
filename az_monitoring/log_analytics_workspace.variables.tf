variable "log_analytics_workspaces" {
  description = "Log Analytics Workspaces"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location          = optional(string) // Location of the Log Analytics Workspace, if not specified, it will use the location of the resource group
    name              = optional(string) // Name of the Log Analytics Workspace, if not specified, it will use the key of the map
    sku               = optional(string, "PerGB2018")
    retention_in_days = optional(number, 30)
    tags              = optional(map(string), {})
    monitoring = optional(object({
      monitoring_log_analytics_workspace_id = optional(string)
      log_category                          = optional(string)
      log_category_group                    = optional(string)
      metrics_enabled                       = optional(bool, true)
      metrics                               = optional(list(string), ["AllMetrics"])
    }), {})
  }))
  default = {}
}

variable "log_analytics_workspace_onboarding" {
  description = "Security Insights Sentinel Onboarding"
  type = map(object({
    workspace_id                 = string
    customer_managed_key_enabled = optional(bool, false)
  }))
  default = {}
}
