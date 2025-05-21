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
  }))
  default = {}
}

variable "express_route_circuit_peerings" {
  description = "Express Route Circuit Peerings"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    express_route_circuit = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    peering_type                  = optional(string, "AzurePrivatePeering")
    peer_asn                      = optional(string)
    shared_key                    = optional(string)
    primary_peer_address_prefix   = optional(string)
    secondary_peer_address_prefix = optional(string)
    ipv4_enabled                  = optional(bool, true)
    vlan_id                       = optional(number)
  }))
  default = {}
}