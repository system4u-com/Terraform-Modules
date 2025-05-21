variable "peerings" {
  description = "Virtual Network Peering"
  type = map(object({
    name = optional(string)
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