variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# variable "default_diagnostic_setting_metrics_enabled" {
#   description = "Enable or disable monitoring for the resources"
#   type        = bool
#   default     = false
# }

# variable "default_diagnostic_setting_logs_enabled" {
#   description = "Enable or disable monitoring for the resources"
#   type        = bool
#   default     = false
# }

# variable "default_diagnostic_setting_excluded_resources" {
#   description = "List of resources to exclude from monitoring"
#   type = list(string)
#   default     = []
# }

# variable "default_diagnostic_setting_log_analytics_workspace_id" {
#   description = "The ID of the Log Analytics Workspace for monitoring"
#   type        = string
#   default     = ""
# }