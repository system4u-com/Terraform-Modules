variable "virtual_network_gateway_connections" {
  description = "Virtual Network Gateway Connections"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location                   = optional(string) // Location of the gateway, if not specified, it will use the location of the resource group
    name                       = optional(string) // Name of the gateway, if not specified, it will use the name of the resource group
    type                       = string
    virtual_network_gateway_id = string
    express_route_circuit_id   = optional(string) // Optional, if not specified, it will not be used
    tags                       = optional(map(string), {})
    monitoring = optional(object({
      log_analytics_workspace_id = optional(string)
      metrics_enabled            = optional(bool, true)
      metrics                    = optional(string)
      }),{})
  }))
  default = {}
}

