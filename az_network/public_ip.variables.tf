variable "public_ips" {
  description = "Public IP Addresses"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name              = optional(string)
    sku               = optional(string, "Standard")
    allocation_method = optional(string, "Static")
    domain_name_label = optional(string)
    tags              = optional(map(string), {})
  }))
  default = {}
}