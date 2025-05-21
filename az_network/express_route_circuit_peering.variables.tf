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