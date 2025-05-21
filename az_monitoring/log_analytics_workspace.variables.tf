variable "log_analytics_workspaces" {
  description = "Log Analytics Workspaces"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location            = optional(string) // Location of the Log Analytics Workspace, if not specified, it will use the location of the resource group
    name                = optional(string) // Name of the Log Analytics Workspace, if not specified, it will use the key of the map
    sku                 = optional(string, "PerGB2018")
    retention_in_days   = optional(number, 30)
  }))
  default = {}
}