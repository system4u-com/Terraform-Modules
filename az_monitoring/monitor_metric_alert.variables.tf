variable "monitor_metric_alerts" {
  description = "Monitor Metric alerts configuration"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name       = optional(string)     // Name of the Alert, if not specified, it will use the key of the map
    description = optional(string) // Description of the action group
    scopes    = optional(list(string), []) // List of resource IDs to monitor
    enabled   = optional(bool, true) // Enable or disable the metric alert
    auto_mitigate = optional(bool, true) // Automatically resolve the alert when the condition is no longer met
    frequency = optional(string, "PT5M") // Frequency of evaluation
    window_size = optional(string) // Time window for evaluation
    severity = optional(number, 3) // Severity of the alert (0-4)
    target_resource_type = optional(string) // This is Required when using a Subscription as scope, a Resource Group as scope or Multiple Scopes.
    target_resource_location = optional(string) // This is Required when using a Subscription as scope, a Resource Group as scope or Multiple Scopes.
    criterias = optional(list(object({
      metric_namespace   = string
      metric_name        = string
      aggregation        = string
      operator           = string // Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual
      threshold          = number
      dimensions         = optional(list(object({
        name     = optional(string)
        operator = optional(string) // Possible values are Include, Exclude and StartsWith
        values   = optional(list(string))
      })), [])
    })), [])
    actions = optional(list(object({
      action_group_id = string
      webhook_properties = optional(map(string), {})
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}