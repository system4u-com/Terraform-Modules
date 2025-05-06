variable "azure_default_location" {
    description = "Default Location"
    default = "northeurope"
}

variable "azure_resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = optional(string, "")
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "azure_virtual_networks" {
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