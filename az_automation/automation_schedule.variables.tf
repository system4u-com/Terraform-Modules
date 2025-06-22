variable "automation_schedules" {
  description = "Azure Automation Schedules"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    automation_account = object({
      id       = string
      name     = string
      location = string
    }) // Automation Account details, required for the schedule
    frequency = string // Frequency of the schedule, e.g., "Hour", "Day", "Week", "Month"
    interval = optional(number, 1) // Interval of the schedule, default is 1
    week_days = optional(list(string), []) // List of weekdays for weekly schedules, e.g., ["Monday", "Wednesday"]
    month_days = optional(list(number), []) // List of days of the month for monthly schedules, e.g., [1, 15]
    monthly_occurrence = optional(object({
      day = optional(string) // Day of the week, e.g., "Monday", "Tuesday"
      occurrence = optional(number) // Occurrence of the day in the month, e.g., 1 for first occurrence, 2 for second occurrence
    }), {}) // Monthly occurrences for schedules
    description = optional(string) // Description of the schedule
    start_time = optional(string) // Start time of the schedule in ISO 8601 format
    expiry_time = optional(string) // Expiry time of the schedule in ISO 8601 format

    tags     = optional(map(string), {})
     
  }))
  default = {}

}
