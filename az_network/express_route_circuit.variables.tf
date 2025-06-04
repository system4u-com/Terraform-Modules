variable "express_route_circuits" {
  description = "Express Route Circuits"
  type = map(object({
    name     = optional(string)
    location = optional(string) // Location of the gateway, if not specified, it will use the location of the resource group
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    service_provider_name    = optional(string)
    peering_location         = optional(string)
    bandwidth_in_mbps        = optional(number)
    express_route_port_id    = optional(string)
    bandwidth_in_gbps        = optional(number)
    allow_classic_operations = optional(bool, false)
    sku = object({
      tier   = string
      family = string
    })
    tags = optional(map(string), {})
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