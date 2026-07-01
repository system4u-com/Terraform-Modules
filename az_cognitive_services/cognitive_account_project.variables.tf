variable "cognitive_account_projects" {
	description = "Azure AI Foundry Projects"
	type = map(object({
		name = optional(string)
		cognitive_account = object({
			id       = string
			name     = string
			location = string
		})
		location     = optional(string) // Location of the project, if not specified, it will use the location of the cognitive account
		description  = optional(string)
		display_name = optional(string)
		identity = object({
			type         = string // SystemAssigned | UserAssigned | SystemAssigned, UserAssigned
			identity_ids = optional(list(string), [])
		})
		tags = optional(map(string), {})
	}))
	default = {}
}
