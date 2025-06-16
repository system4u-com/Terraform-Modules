variable "application_groups" {
  description = "List of AVD application groups"
  type = map(object({
    resource_group = object({
      name     = string
      location = string
    })
    location                 = optional(string)
    name                     = optional(string)
    type                     = string
    host_pool_id = string
    friendly_name = optional(string)
    description   = optional(string)
    default_desktop_display_name = optional(string)
    tags         = optional(map(string), {})
  }))
  default = {}
}

variable "workspace_application_group_associations" {
  description = "List of AVD workspace application group associations"
  type = map(object({
    application_group_id = string
    workspace_id         = string
  }))
  default = {}
}