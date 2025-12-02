resource "azurerm_virtual_desktop_scaling_plan" "avd_scaling_plans" {
  for_each = var.scaling_plans

  resource_group_name      = each.value.resource_group.name
  location                 = coalesce(each.value.location, each.value.resource_group.location)
  name                     = coalesce(each.value.name, each.key)
  friendly_name            = each.value.friendly_name
  description              = each.value.description
  time_zone                = each.value.time_zone

  dynamic "schedule" {
    for_each = each.value.schedules
    content {
      name                 = coalesce(schedule.value.name, schedule.key)
      days_of_week         = schedule.value.days_of_week
      off_peak_load_balancing_algorithm = schedule.value.off_peak_load_balancing_algorithm
      off_peak_start_time  = schedule.value.off_peak_start_time
      peak_load_balancing_algorithm = schedule.value.peak_load_balancing_algorithm
      peak_start_time      = schedule.value.peak_start_time
      ramp_down_capacity_threshold_percent = schedule.value.ramp_down_capacity_threshold_percent
      ramp_down_force_logoff_users = schedule.value.ramp_down_force_logoff_users
      ramp_down_load_balancing_algorithm = schedule.value.ramp_down_load_balancing_algorithm
      ramp_down_minimum_hosts_percent = schedule.value.ramp_down_minimum_hosts_percent
      ramp_down_notification_message = schedule.value.ramp_down_notification_message
      ramp_down_start_time = schedule.value.ramp_down_start_time
      ramp_down_stop_hosts_when = schedule.value.ramp_down_stop_hosts_when
      ramp_down_wait_time_minutes = schedule.value.ramp_down_wait_time_minutes
      ramp_up_load_balancing_algorithm = schedule.value.ramp_up_load_balancing_algorithm
      ramp_up_start_time     = schedule.value.ramp_up_start_time
      ramp_up_capacity_threshold_percent = schedule.value.ramp_up_capacity_threshold_percent
      ramp_up_minimum_hosts_percent = schedule.value.ramp_up_minimum_hosts_percent
    }
  }

  dynamic "host_pool" {
    for_each = each.value.host_pools
    content {
      hostpool_id = host_pool.value.hostpool_id
      scaling_plan_enabled = host_pool.value.scaling_plan_enabled
    }
  }
  
  tags                     = merge(var.default_tags, each.value.tags)
}
