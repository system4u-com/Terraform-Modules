variable "scaling_plans" {
  description = "List of host pools to create"
  type = map(object({
    resource_group = object({
      name     = string
      location = string
    })
    location                 = optional(string)
    name                     = optional(string)
    friendly_name            = optional(string)
    description       = optional(string)
    time_zone            = optional(string, "GMT Standard Time")
    schedules = map(object({
      name                 = optional(string)
      days_of_week         = optional(list(string), ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
      off_peak_load_balancing_algorithm = optional(string, "DepthFirst")
      off_peak_start_time  = optional(string, "18:00")
      peak_load_balancing_algorithm = optional(string, "DepthFirst")
      peak_start_time      = optional(string, "09:00")
      ramp_down_capacity_threshold_percent = optional(number, 15)
      ramp_down_force_logoff_users = optional(bool, false)
      ramp_down_load_balancing_algorithm = optional(string, "DepthFirst")
      ramp_down_minimum_hosts_percent = optional(number, 10)
      ramp_down_notification_message = optional(string, "The host pool will be scaled down soon. Please save your work, before you are logged off.")
      ramp_down_start_time = optional(string, "17:00")
      ramp_down_stop_hosts_when = optional(string, "ZeroActiveSessions")
      ramp_down_wait_time_minutes = optional(number, 30)
      ramp_up_load_balancing_algorithm = optional(string, "DepthFirst")
      ramp_up_start_time     = optional(string, "08:00")
      ramp_up_capacity_threshold_percent = optional(number, 80)
      ramp_up_minimum_hosts_percent = optional(number, 10)
    }))
    host_pools = optional(map(object({
      hostpool_id = optional(string),
      scaling_plan_enabled = optional(bool, true)
    })), {})
    tags                     = optional(map(string), {})
  }))
  default = {}
}
