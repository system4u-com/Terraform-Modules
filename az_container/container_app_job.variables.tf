variable "container_app_jobs" {
  description = "A map of container app environments to create."
  type = map(object({
    name = optional(string)
    location = optional(string)
    resource_group = object({
      name = string
      location = string
      id = string
    })
    container_app_environment = optional(object({
      name = string
      id = string
    }))
    replica_timeout_in_seconds = optional(number, 120)
    replica_retry_limit = optional(number, 3)
    schedule_trigger_config = optional(object({
      cron_expression = optional(string)
    }), {})
    identity = optional(object({
      type = optional(string, "SystemAssigned")
      identity_ids = optional(list(string), [])
    }), {})
    registry = optional(object({
      server = optional(string)
      username = optional(string)
      password_secret_name = optional(string)
    }), {})
    secrets = optional(map(object({
      name = optional(string)
      identity = optional(string)
      key_vault_secret_id = optional(string)
      value = optional(string)
    })), {})
    template = object({
      container = optional(object({
        name = optional(string)
        cpu = optional(string, "0.5")
        memory = optional(string, "1.0Gi")
        image = optional(string)
        env = optional(list(object({
          name = string
          value = string
        })), [])
      }), {})
    })
    tags = optional(map(string), {})

  }))
  default = {}

}
