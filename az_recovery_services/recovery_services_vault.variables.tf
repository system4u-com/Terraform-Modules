variable "recovery_services_vaults" {
  description = "Recovery Services Vaults"
  type = map(object({
    location = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name              = optional(string)
    sku               = optional(string, "Standard")
    storage_mode_type = optional(string, "GeoRedundant") # Options: "GeoRedundant", "LocallyRedundant", "ZoneRedundant"
    immutability      = optional(string, "Locked")       # Options: "Locked", "Unlocked", "Disabled"
    tags              = optional(map(string), {})
    ip_configurations = map(object({
      subnet_id                     = optional(string)
      public_ip_address_id          = optional(string)
      private_ip_address_allocation = optional(string, "Dynamic") // The only value is Dynamic, Static is not supported
    }))
  }))
  default = {}
}
