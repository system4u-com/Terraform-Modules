variable "host_pools" {
  description = "List of host pools to create"
  type = map(object({
    resource_group = object({
      name     = string
      location = string
    })
    location                 = optional(string)
    name                     = optional(string)
    type                     = optional(string, "Pooled")
    load_balancer_type       = optional(string, "BreadthFirst")
    friendly_name            = optional(string)
    description              = optional(string)
    validate_environment     = optional(bool, false)
    start_vm_on_connect      = optional(bool, false)
    custom_rdp_properties    = optional(string)
    maximum_sessions_allowed = optional(number)
    tags                     = optional(map(string), {})
  }))
}
