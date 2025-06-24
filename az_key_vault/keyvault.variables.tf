variable "key_vaults" {
  description = "Azure Storage Accounts"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location                   = optional(string) // Location of the Storage Account, if not specified, it will use the location of the resource group
    sku_name                   = optional(string, "standard")
    tenant_id                  = optional(string)
    soft_delete_retention_days = optional(number, 30)
    purge_protection_enabled   = optional(bool, false)
    enable_rbac_authorization = optional(bool, true)
    tags = optional(map(string), {})
  }))
}
