variable "route_tables" {
  description = "Route Tables"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    subnet_association = optional(object({
      id = string
    }), null)
    tags = optional(map(string), {})
    routes = optional(map(object({
      address_prefix         = optional(string)
      next_hop_type          = string           // VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None
      next_hop_in_ip_address = optional(string) // Only for VirtualAppliance
    })), {})
  }))
  default = {}
}