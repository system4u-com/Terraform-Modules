variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "marketplace_agreements" {
  description = "Azure Marketplace Agreements"
  type = map(object({
    publisher = optional(string)
    offer   = optional(string)
    plan   = optional(string)
  }))
  default = {}
}
