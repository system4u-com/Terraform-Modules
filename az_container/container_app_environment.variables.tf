variable "container_app_environments" {
  description = "A map of container app environments to create."
  type = map(object({
    name     = optional(string)
    location = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    tags                       = optional(map(string), {})
    logs_destination           = optional(string)
    log_analytics_workspace_id = optional(string)
  }))
  default = {}

}
