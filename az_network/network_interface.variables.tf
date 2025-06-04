variable "network_interfaces" {
  description = "Network Interfaces"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    ip_forwarding_enabled           = optional(bool,false)
    ip_configurations = map(object({
      subnet_id                     = optional(string)
      public_ip_address_id          = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic") // Dynamic | Static
      private_ip_address_version    = optional(string, "IPv4")    // IPv4 | IPv6
      private_ip_address            = optional(string)
    }))
    tags = optional(map(string), {})
    monitoring = optional(object({
      monitoring_log_analytics_workspace_id = optional(string)
      metrics_enabled            = optional(bool, true)
      metrics                    = optional(string)
    }), {})
  }))
  default = {}
}