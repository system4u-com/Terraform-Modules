variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}