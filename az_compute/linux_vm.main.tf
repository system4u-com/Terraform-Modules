resource "azurerm_linux_virtual_machine" "linux_vms" {
  for_each = var.linux_virtual_machines

  name                            = each.key
  resource_group_name             = each.value.resource_group.name
  location                        = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = each.value.network_interface_ids

  dynamic "admin_ssh_key" {
    for_each = each.value.admin_ssh_keys

    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  dynamic "plan" {
    for_each = each.value.plan != null ? [each.value.plan] : []

    content {
      name      = plan.value.name
      publisher = plan.value.publisher
      product   = plan.value.product
    }
  }

  tags = each.value.tags
}

# data "azurerm_monitor_diagnostic_categories" "linux_vms_diagnostic_categories" {
#   for_each = var.linux_virtual_machines

#   resource_id = azurerm_linux_virtual_machine.linux_vms[each.key].id
# }

# locals {
#   linux_vms_diagnostic_enabled = {
#     for k, v in azurerm_linux_virtual_machine.linux_vms : k => v if !contains(var.default_diagnostic_setting_excluded_resources, v.id)
#   }
# }

# resource "azurerm_monitor_diagnostic_setting" "linux_vms_diagnostic_settings" {
#   for_each = var.default_diagnostic_setting_logs_enabled || var.default_diagnostic_setting_metrics_enabled ? local.linux_vms_diagnostic_enabled : {}

#   name               = "Default-Diagnostic-Setting"
#   target_resource_id = azurerm_linux_virtual_machine.linux_vms[each.key].id
#   log_analytics_workspace_id = var.default_diagnostic_setting_log_analytics_workspace_id

#   dynamic "enabled_log" {
#     for_each = var.default_diagnostic_setting_logs_enabled ? data.azurerm_monitor_diagnostic_categories.linux_vms_diagnostic_categories[each.key].log_category_types : []

#     content {
#       category = enabled_log.value
#     }
#   }

#   dynamic "metric" {
#     for_each = var.default_diagnostic_setting_metrics_enabled ? data.azurerm_monitor_diagnostic_categories.linux_vms_diagnostic_categories[each.key].metrics : []

#     content {
#       category = metric.value
#     }
    
#   }
# }