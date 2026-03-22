resource "azurerm_email_communication_service_domain" "email_communication_service_domains" {
    for_each = var.email_communication_service_domains

    name                = coalesce(each.value.name, each.key)
    email_service_id = each.value.email_service.id
    domain_management = each.value.domain_management
    user_engagement_tracking_enabled = each.value.user_engagement_tracking_enabled
    tags = each.value.tags

    depends_on = [azurerm_email_communication_service.email_communication_services]
}