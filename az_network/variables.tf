variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for monitoring"
  type        = string
  default     = ""
}