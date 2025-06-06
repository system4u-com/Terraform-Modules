variable "diagnostic_settings" {
  description = "Diagnostic settings for resources"
  type = map(object({
    name                       = string
    log_analytics_workspace_id = string
    disable_logs               = optional(bool, false)
    disable_metrics            = optional(bool, false)
    log_categories             = optional(list(string), [])
    metric_categories          = optional(list(string), [])
    target_resource_ids        = list(string)
  }))
  default = {}
}
