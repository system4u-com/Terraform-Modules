resource "azurerm_storage_share" "storage_shares" {
  for_each = var.storage_shares

  name               = coalesce(each.value.name, each.key)
  storage_account_id = each.value.storage_account.id
  quota              = coalesce(each.value.quota, 5120)        // Default quota is 5120 GB
  access_tier        = coalesce(each.value.access_tier, "Hot") // Default access tier is Hot
  metadata           = coalesce(each.value.metadata, {})
  enabled_protocol   = coalesce(each.value.enabled_protocol, "SMB") // Default protocol is SMB

  dynamic "acl" {
    for_each = each.value.acl != null ? [each.value.acl] : []

    content {
      id = "${coalesce(each.value.name, each.key)}-${coalesce(acl.value.name, acl.key)}"
      access_policy {
        permissions = acl.value.permissions
        start       = acl.value.start
        expiry      = acl.value.expiry
      }
    }
  }
  lifecycle {
    ignore_changes = [
      metadata,
      acl //  Metadata changes are not supported for storage shares
    ]
  }
}
