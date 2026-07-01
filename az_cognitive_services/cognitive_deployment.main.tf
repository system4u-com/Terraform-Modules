resource "azurerm_cognitive_deployment" "cognitive_deployments" {
	for_each = var.cognitive_deployments

	name                       = coalesce(each.value.name, each.key)
	cognitive_account_id       = each.value.cognitive_account.id
	dynamic_throttling_enabled = each.value.dynamic_throttling_enabled
	rai_policy_name            = each.value.rai_policy_name
	version_upgrade_option     = each.value.version_upgrade_option

	model {
		format  = each.value.model.format
		name    = each.value.model.name
		version = each.value.model.version
	}

	sku {
		name     = each.value.sku.name
		tier     = each.value.sku.tier
		size     = each.value.sku.size
		family   = each.value.sku.family
		capacity = each.value.sku.capacity
	}
}
