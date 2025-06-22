resource "azurerm_automation_schedule" "automation_schedules" {
  for_each = var.automation_schedules

  name                    = coalesce(each.value.name, each.key)
  resource_group_name     = each.value.resource_group.name
  automation_account_name = each.value.automation_account.name
  description             = each.value.description
  start_time              = each.value.start_time
  expiry_time             = each.value.expiry_time
  frequency               = each.value.frequency
  interval                = coalesce(each.value.interval, 1)    // Default to 1 if not specified
  week_days               = coalesce(each.value.week_days, [])  // Default to empty list if not specified
  month_days              = coalesce(each.value.month_days, []) // Default to empty list if not specified
  monthly_occurrence {
    day        = each.value.monthly_occurrence.day
    occurrence = each.value.monthly_occurrence.occurrence
  }
}
