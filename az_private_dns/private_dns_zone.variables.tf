variable "private_dns_zones" {
  description = "Private DNS zones"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id   = string
      name = string
    })
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "unmanaged_private_dns_zones" {
  description = "Existing Private DNS zones"
  type = map(object({
    name                = string
    resource_group_name = string
  }))
  default = {}
}
