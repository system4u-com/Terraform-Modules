variable "subnets" {
  description = "Subnets"
  type = map(object({
    name = optional(string)
    virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    address_prefixes = list(string)
    service_endpoints = optional(list(string))
  }))
  default = {}
}