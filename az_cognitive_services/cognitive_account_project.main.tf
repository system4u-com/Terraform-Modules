resource "azurerm_cognitive_account_project" "cognitive_account_projects" {
	for_each = var.cognitive_account_projects

	name                 = coalesce(each.value.name, each.key)
	cognitive_account_id = each.value.cognitive_account.id
	location             = coalesce(each.value.location, each.value.cognitive_account.location)
	description          = each.value.description
	display_name         = each.value.display_name
	tags                 = each.value.tags

	identity {
		type         = each.value.identity.type
		identity_ids = each.value.identity.identity_ids
	}
}
