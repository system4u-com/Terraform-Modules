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
    monitoring = optional(object({
      alerts_for_all_job_failures_enabled = optional(bool) // Enable alerts for all job failures
      alerts_for_critical_operation_failures_enabled = optional(bool) // Enable alerts for critical operation failures
    }))
    tags              = optional(map(string), {})
  }))
  default = {}
}
