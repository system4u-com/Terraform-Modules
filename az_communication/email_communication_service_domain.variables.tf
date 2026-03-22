variable "email_communication_service_domains" {
  description = "Azure Communication Services for Email associatedDomains"
  type = map(object({
    name = optional(string)
    email_service = object({
      id       = string
      name     = string
    })
    domain_management = string // Type of domain management - "AzureManaged" or "CustomerManaged" 
    user_engagement_tracking_enabled = optional(bool, false) // Whether user engagement tracking is enabled for the domain
    tags = optional(map(string), {})
  }))  
}