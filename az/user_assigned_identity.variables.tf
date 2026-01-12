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