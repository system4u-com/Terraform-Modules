variable "storage_accounts" {
  description = "Azure Storage Accounts"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location                   = optional(string) // Location of the Storage Account, if not specified, it will use the location of the resource group
    account_tier               = optional(string, "Standard")
    account_kind               = optional(string, "StorageV2")
    account_replication_type   = optional(string, "LRS")
    access_tier                = optional(string, "Hot")
    https_traffic_only_enabled = optional(bool, true)
    allow_nested_items_to_be_public = optional(bool, true)
    network_rules = optional(object({
      bypass         = optional(list(string), ["None"]) // None | Logging | Metrics | AzureServices
      default_action = optional(string, "Deny")         // Allow | Deny
      ip_rules       = optional(list(string), [])
      virtual_network_subnets = optional(list(object({
        id = string
      })), [])
    }))
    tags = optional(map(string), {})
  }))
}
