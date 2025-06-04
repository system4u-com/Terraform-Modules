variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name          = optional(string)
    address_space = list(string)
    dns_servers   = optional(list(string), [])
    tags          = optional(map(string), {})
    monitoring = optional(object({
      monitoring_log_analytics_workspace_id = optional(string)
      log_category               = optional(string)
      log_category_group         = optional(string)
      metrics_enabled            = optional(bool, true)
      metrics                    = optional(string)
    }), {})
  }))
  default = {}
}
