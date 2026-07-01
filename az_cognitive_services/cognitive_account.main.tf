resource "azurerm_cognitive_account" "cognitive_accounts" {
	for_each = var.cognitive_accounts

	name                             = coalesce(each.value.name, each.key)
	resource_group_name              = each.value.resource_group.name
	location                         = coalesce(each.value.location, each.value.resource_group.location)
	kind                             = each.value.kind
	sku_name                         = each.value.sku_name
	custom_subdomain_name            = each.value.custom_subdomain_name
	dynamic_throttling_enabled       = each.value.dynamic_throttling_enabled
	project_management_enabled       = each.value.project_management_enabled
	local_auth_enabled               = each.value.local_auth_enabled
	public_network_access_enabled    = each.value.public_network_access_enabled
	outbound_network_access_restricted = each.value.outbound_network_access_restricted
	tags                             = each.value.tags

	dynamic "identity" {
		for_each = each.value.identity != null ? [each.value.identity] : []

		content {
			type         = identity.value.type
			identity_ids = identity.value.identity_ids
		}
	}

	dynamic "network_acls" {
		for_each = each.value.network_acls != null ? [each.value.network_acls] : []

		content {
			default_action = network_acls.value.default_action
			bypass         = network_acls.value.bypass
			ip_rules       = network_acls.value.ip_rules

			dynamic "virtual_network_rules" {
				for_each = network_acls.value.virtual_network_subnets

				content {
					subnet_id                            = virtual_network_rules.value.id
					ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
				}
			}
		}
	}
}
