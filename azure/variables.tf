variable "default_location" {
  description = "Default Location"
  default     = "northeurope"
}

variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = optional(string, "")
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "public_ips" {
  description = "Public IP Addresses"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    sku               = optional(string, "Standard")
    allocation_method = optional(string, "Static")
    domain_name_label = optional(string, null)
    tags              = optional(map(string), {})
  }))
  default = {}
}

variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    address_space = list(string)
    dns_servers   = optional(list(string), [])
    tags          = optional(map(string), {})
  }))
  default = {}
}

variable "subnets" {
  description = "Subnets"
  type = map(object({
    virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    address_prefixes = list(string)
  }))
  default = {}
}

variable "peerings" {
  description = "Virtual Network Peering"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    remote_virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    allow_virtual_network_access = optional(bool, true)
  }))
  default = {}
}

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
      source_address_prefix        = optional(string, null)
      source_address_prefixes      = optional(list(string), null)
      source_port_range            = optional(string, null)
      source_port_ranges           = optional(list(string), null)
      destination_address_prefix   = optional(string, null)
      destination_address_prefixes = optional(list(string), null)
      destination_port_range       = optional(string, null)
      destination_port_ranges      = optional(list(string), null)
      description                  = optional(string)
    })), {})
  }))
  default = {}
}
