variable "default_location" {
    description = "Default Location"
    default = "northeurope"
}

variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = optional(string, "")
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    resource_group = object({
        id = string
        name = string
        location = string
    })
    address_space = list(string)
    dns_servers = optional(list(string), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "subnets" {
  description = "Subnets"
  type = map(object({
    virtual_network = object({
        id = string
        name = string
        location = string
        resource_group_name = string
    })
    address_prefixes = list(string)
  }))
  default = {}
}