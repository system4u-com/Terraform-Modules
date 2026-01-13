variable "monitor_scheduled_query_rules_logs" {
  description = "Monitor Scheduled Query Rules Logs configuration"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name                    = optional(string)     // Name of the Alert, if not specified, it will use the key of the map
    location                = optional(string)     // Location of the Alert, if not specified, it will use the location from the resource group
    description             = optional(string)     // Description of the action group
    enabled                 = optional(bool, true) // Enable or disable the metric alert
    authorized_resource_ids = optional(list(string))
    data_source_id          = string // The ID of the resource to monitor
    criteria = object({
      metric_name = string
      dimension = object({
        name     = optional(string)
        operator = optional(string) // Possible values are Include, Exclude and StartsWith
        values   = optional(list(string))
      })
    })
    tags = optional(map(string), {})
  }))
  default = {}
}
