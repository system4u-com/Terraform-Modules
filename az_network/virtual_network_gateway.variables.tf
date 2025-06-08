variable "virtual_network_gateways" {
  description = "Virtual Network Gateways"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string) // Location of the gateway, if not specified, it will use the location of the resource group
    name     = optional(string) // Name of the gateway, if not specified, it will use the name of the resource group
    type     = string
    sku      = string
    ip_configurations = map(object({
      subnet_id                     = optional(string)
      public_ip_address_id          = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic") // The only value is Dynamic, Static is not supported
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}