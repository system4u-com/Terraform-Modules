variable "network_security_groups" {
  description = "Network Security Groups"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    subnet_association = optional(object({
      id = string
    }), null)
    nic_association = optional(object({
      id = string
    }), null)
    tags = optional(map(string), {})
    rules = optional(map(object({
      priority                     = string
      direction                    = string                // Inbound | Outbound
      access                       = string                // Allow | Deny
      protocol                     = optional(string, "*") // Tcp | Udp | Icmp | Esp | Ah | *
      source_address_prefix        = optional(string)
      source_address_prefixes      = optional(list(string), null)
      source_port_range            = optional(string)
      source_port_ranges           = optional(list(string), null)
      destination_address_prefix   = optional(string)
      destination_address_prefixes = optional(list(string), null)
      destination_port_range       = optional(string)
      destination_port_ranges      = optional(list(string))
      description                  = optional(string)
    })), {})
  }))
  default = {}
}