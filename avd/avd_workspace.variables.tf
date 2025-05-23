variable "workspaces" {
  description = "List of workspaces to create"
  type = map(object({
    name     = optional(string)
    location = optional(string)
    resource_group = object({
      name     = string
      location = string
    })
    friendly_name = optional(string)
    description   = optional(string)
    tags          = optional(map(string), {})
  }))
  default = {}
}
