variable "storage_sync_groups" {
  description = "Azure Storage Sync Groups"
  type = map(object({
    name = optional(string)
    storage_sync = object({
      id       = string
    })
  }))
}
