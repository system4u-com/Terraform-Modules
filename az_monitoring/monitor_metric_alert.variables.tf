variable "monitor_metric_alerts" {
  description = "Monitor Action Groups"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name       = optional(string)     // Name of the Log Analytics Workspace, if not specified, it will use the key of the map
    description = optional(string) // Description of the action group
    scopes    = optional(list(string), []) // List of resource IDs to monitor
    criterias = optional(list(object({
      metric_name        = string
      metric_namespace   = string
      operator           = string
      aggregation        = string
      threshold          = number
      dimensions         = optional(list(object({
        name     = string
        operator = string
        values   = list(string)
      })), [])
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}