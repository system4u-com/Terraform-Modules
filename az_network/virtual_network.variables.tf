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