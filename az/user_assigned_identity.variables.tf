variable "user_assigned_identities" {
  description = "User Assigned Identities"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string)
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "unmanaged_user_assigned_identities" {
  description = "Unmanaged User Assigned Identities"
  type = map(object({
    name                = string
    resource_group_name = string
  }))
  default = {}
}
