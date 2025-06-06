variable "monitor_diagnostic_settings" {
  description = "Diagnostic settings for resources"
  type = map(object({
    name                       = string
    resource_id                = string
    log_analytics_workspace_id = optional(string)
    log_categories             = optional(list(string), [])
    metric_categories          = optional(list(string), [])
  }))
  default = {}
}
