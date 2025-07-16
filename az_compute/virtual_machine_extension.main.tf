resource "azurerm_virtual_machine_extension" "virtual_machine_extensions" {
  for_each = {
    for item in flatten([
      for ext_key, ext_value in var.virtual_machine_extensions : [
        for idx, vm_id in ext_value.virtual_machine_ids : {
          key                        = "${ext_key}-${split("/", vm_id)[length(split("/", vm_id)) - 1]}"
          name                       = coalesce(ext_value.name, ext_key)
          virtual_machine_id         = vm_id
          publisher                  = ext_value.publisher
          type                       = ext_value.type
          type_handler_version       = ext_value.type_handler_version
          auto_upgrade_minor_version = ext_value.auto_upgrade_minor_version
          settings                   = ext_value.settings
          protected_settings         = ext_value.protected_settings
          automatic_upgrade_enabled  = ext_value.automatic_upgrade_enabled
          tags                       = ext_value.tags
        }
      ]
    ]) : item.key => item
  }

  name                       = "${each.value.name}-${split("/", each.value.virtual_machine_id)[length(split("/", each.value.virtual_machine_id)) - 1]}"
  virtual_machine_id         = each.value.virtual_machine_id
  publisher                  = each.value.publisher
  type                       = each.value.type
  type_handler_version       = each.value.type_handler_version
  auto_upgrade_minor_version = each.value.auto_upgrade_minor_version
  settings                   = each.value.settings
  protected_settings         = each.value.protected_settings
  automatic_upgrade_enabled  = each.value.automatic_upgrade_enabled
  tags                       = each.value.tags
}