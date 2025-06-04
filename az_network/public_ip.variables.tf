variable "public_ips" {
  description = "Public IP Addresses"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name              = optional(string)
    sku               = optional(string, "Standard")
    allocation_method = optional(string, "Static")
    domain_name_label = optional(string)
    tags              = optional(map(string), {})
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