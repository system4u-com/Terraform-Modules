variable "application_insights" {
  description = "Application Insights resources"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location          = optional(string)
    application_type  = optional(string, "web")
    workspace_id      = optional(string)
    retention_in_days = optional(number, 90)
    tags              = optional(map(string), {})
  }))
  default = {}
}