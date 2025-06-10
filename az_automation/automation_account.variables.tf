variable "automation_accounts" {
  description = "Azure Automation Accounts"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string) // Location of the Automation Account, if not specified, it will use the location of the resource group
    sku_name = optional(string, "Free")
    tags     = optional(map(string), {})
    identity = optional(object({
      type         = optional(string) // Type of the identity, e.g., "SystemAssigned", "UserAssigned", "UserAssigned, SystemAssigned"
      identity_ids = optional(map(string))
    }), {}) 
  }))
  default = {}

}
