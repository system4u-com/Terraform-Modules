variable "private_dns_zone_virtual_network_links" {
  description = "Links between Private DNS zones and virtual networks"
  type = map(object({
    zone_key             = string
    virtual_network_id   = string
    name                 = optional(string)
    registration_enabled = optional(bool, false)
    tags                 = optional(map(string), {})
  }))
  default = {}
}
