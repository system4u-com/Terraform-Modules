variable "monitoring_log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for monitoring"
  type        = string
  default     = ""
}

variable "monitoring_enabled" {
  description = "Enable or disable monitoring for the resources"
  type        = bool
  default     = false
}

variable "monitoring_included_resources" {
  description = "List of resources to include in monitoring"
  type        = list(string)
  default     = []
}

variable "monitoring_excluded_resources" {
  description = "List of resources to exclude from monitoring"
  type = list(string)
  default     = []
}

variable "custom_diagnostic_setting_name_prefix" {
  description = "Prefix for the custom diagnostic setting name"
  type        = string
  default     = "Custom-"
}