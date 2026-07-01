variable "cognitive_deployments" {
	description = "Azure AI model deployments in Cognitive Services / Azure AI Foundry"
	type = map(object({
		name = optional(string)
		cognitive_account = object({
			id       = string
			name     = string
			location = string
		})
		dynamic_throttling_enabled = optional(bool)
		rai_policy_name            = optional(string)
		version_upgrade_option     = optional(string, "NoAutoUpgrade") // NoAutoUpgrade | OnceCurrentVersionExpired | OnceNewDefaultVersionAvailable
		model = object({
			format  = string
			name    = string
			version = optional(string)
		})
		sku = object({
			name     = optional(string, "Standard")
			tier     = optional(string)
			size     = optional(string)
			family   = optional(string)
			capacity = optional(number)
		})
	}))
	default = {}
}
