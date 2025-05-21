variable "marketplace_agreements" {
  description = "Azure Marketplace Agreements"
  type = map(object({
    publisher = optional(string)
    offer   = optional(string)
    plan   = optional(string)
  }))
  default = {}
}