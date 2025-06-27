resource "azurerm_resource_provider_registration" "resource_provider_registrations" {
  for_each = var.resource_provider_registrations

  name     = coalesce(each.value.name, each.key)
  dynamic "feature" {
    for_each = each.value.features
    content {
    name = coalesce(feature.value.name, feature.key)
    registered = feature.value.registered
    
  }
}
}