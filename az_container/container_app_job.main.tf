resource "azurerm_container_app_job" "container_app_jobs" {
  for_each = var.container_app_jobs

  name                         = coalesce(each.value.name, each.key)
  location                     = coalesce(each.value.location, each.value.resource_group.location)
  resource_group_name          = each.value.resource_group.name
  container_app_environment_id = each.value.container_app_environment.id
  replica_timeout_in_seconds   = each.value.replica_timeout_in_seconds
  replica_retry_limit          = each.value.replica_retry_limit
  schedule_trigger_config {
    cron_expression = each.value.schedule_trigger_config.cron_expression
  }
  dynamic "identity" {
    for_each = each.value.identity == null ? [] : [each.value.identity]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  registry {
    server               = each.value.registry.server
    username             = each.value.registry.username
    password_secret_name = each.value.registry.password_secret_name
  }
  dynamic "secret" {
    for_each = each.value.secrets == null ? [] : [for k, v in each.value.secrets : merge({ name = k }, v != null ? v : {})]
    content {
      name                = secret.value.name
      identity            = secret.value.identity
      key_vault_secret_id = secret.value.key_vault_secret_id
      value               = secret.value.value
    }
  }
  template {
    container {
      name   = each.value.template.container.name
      cpu    = each.value.template.container.cpu
      memory = each.value.template.container.memory
      image  = each.value.template.container.image
      dynamic "env" {
        for_each = each.value.template.container.env == null ? [] : each.value.template.container.env
        content {
          name  = env.value.name
          value = env.value.value
        }
      }
    }
  }
}
