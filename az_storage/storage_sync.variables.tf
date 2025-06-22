variable "storage_syncs" {
  description = "Azure Storage Shares"
  type = map(object({
    name = optional(string)
    resource_group = object({
      name     = string
      id       = string
      location = string // Location of the resource group
    })
    location                = optional(string)                    // Location of the storage sync, defaults to resource group location
    incoming_traffic_policy = optional(string, "AllowAllTraffic") // Possible values are AllowAllTraffic and AllowVirtualNetworksOnly
    tags                    = optional(map(string), {})           // Tags for the storage sync
  }))
}
