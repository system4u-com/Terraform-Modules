variable "cognitive_accounts" {
	description = "Azure Cognitive Services / Azure AI Foundry Accounts"
	type = map(object({
		name = optional(string)
		resource_group = object({
			id       = string
			name     = string
			location = string
		})
		location                           = optional(string) // Location of the Cognitive Account, if not specified, it will use the location of the resource group
		kind                               = optional(string, "AIServices")
		sku_name                           = optional(string, "S0")
		custom_subdomain_name              = optional(string)
		dynamic_throttling_enabled         = optional(bool)
		project_management_enabled         = optional(bool, true)
		local_auth_enabled                 = optional(bool, true)
		public_network_access_enabled      = optional(bool, true)
		outbound_network_access_restricted = optional(bool, false)
		identity = optional(object({
			type         = string // SystemAssigned | UserAssigned | SystemAssigned, UserAssigned
			identity_ids = optional(list(string), [])
		}))
		network_acls = optional(object({
			default_action = optional(string, "Deny") // Allow | Deny
			bypass         = optional(string, "None") // None | AzureServices
			ip_rules       = optional(list(string), [])
			virtual_network_subnets = optional(list(object({
				id                                   = string
				ignore_missing_vnet_service_endpoint = optional(bool, false)
			})), [])
		}))
		tags = optional(map(string), {})
	}))
	default = {}
}
