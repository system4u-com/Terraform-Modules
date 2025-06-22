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
    })) 
    publish_content_link = optional(object({
      uri = optional(string) // URI to the content to be published
      version = optional(string) // Version of the content
      content_hash = optional(object({
        algorithm = optional(string) // Algorithm used for the content hash, e.g., "SHA256"
        value     = optional(string) // The actual hash value
      }))
    }), {})
    content = optional(string)
    
  }))
  default = {}

}
