variable "storage_shares" {
  description = "Azure Storage Shares"
  type = map(object({
    name                = optional(string)
    storage_account = object({
      name = string
      id = string
    })
    quota               = optional(number, 100) // Quota in GiB, default is 100 GiB
    access_tier         = optional(string) // Access tier for the share, default is Hot
    metadata            = optional(map(string),{}) // Metadata for the share
    enabled_protocol = optional(string, "SMB") // Protocols enabled for the share, default is SMB
    acl = optional(map(object({
        name = optional(string) // Name of the ACL entry
        permissions = optional(string) // Permissions for the ACL entry, e.g., "rwdl"
        start = optional(string) // Start time for the ACL entry in ISO 8601 format
        expiry = optional(string) // Expiry time for the ACL entry in ISO 8601
    })))
  }))
}