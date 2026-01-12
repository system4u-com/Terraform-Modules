variable "scheduled_query_rules_alerts" {
  description = "Scheduled Query Rules alerts configuration"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name                              = optional(string) // Name of the Log Analytics Workspace, if not specified, it will use the key of the map
    description                       = optional(string) // Description of the action group
    location                          = optional(string)
    scopes                            = list(string)          // List of resource IDs to monitor
    enabled                           = optional(bool, true)  // Enable or disable the metric alert
    display_name                      = optional(string)      // Display name of the alert
    auto_mitigation_enabled           = optional(bool, true)  // Automatically resolve the alert when the condition is no longer met
    workspace_alerts_storage_enabled  = optional(bool, false) // Enable storage of alerts in Log Analytics Workspace
    evaluation_frequency              = optional(string)      // Frequency of evaluation
    window_duration                   = string                // Time window for evaluation
    severity                          = number                // Severity of the alert (0-4)
    target_resource_types              = optional(list(string))      // This is Required when using a Subscription as scope, a Resource Group as scope or Multiple Scopes.
    mute_actions_after_alert_duration = optional(string)      // Mute actions after alert duration
    query_time_range_override         = optional(string)      // Override the time range for the query
    skip_query_validation             = optional(bool, false) // Skip query validation
    resource_id_column                = optional(string)      // Column name for resource ID in the query result
    criteria = object({
      query                   = string
      time_aggregation_method = string //Possible values are Average, Count, Maximum, Minimum,and Total
      metric_measure_column   = optional(string) // Column name for metric measure in the query result
      operator                = string // Possible values are Equals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual
      threshold               = number
      resource_id_column      = optional(string) // Column name for resource ID in the query result
      failing_periods = optional(object({
        minimum_failing_periods_to_trigger_alert = number // Minimum number of failing periods to trigger the alert
        number_of_evaluation_periods             = number // Number of evaluation periods
      }))
      dimension = optional(object({
        name     = string
        operator = string // Possible values are Include, Exclude
        values   = list(string)
      }))
    })
    action = optional(object({
      action_groups     = optional(list(string))
      custom_properties = optional(map(string))
    }))
    identity = optional(object({
      type         = string                     // Type of the identity, e.g. "SystemAssigned", "UserAssigned", "None"
      identity_ids = optional(list(string), []) // List of User Assigned Identity IDs
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}
