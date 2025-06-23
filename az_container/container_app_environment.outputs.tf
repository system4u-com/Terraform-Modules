output "container_app_environments" {
    value = {
        for name, env in azurerm_container_app_environment.container_app_environments :
        name => {
            id = env.id
            name = env.name
            location = env.location
            resource_group_name = env.resource_group_name
            tags = env.tags
            logs_destination = env.logs_destination
            log_analytics_workspace_id = env.log_analytics_workspace_id
        }
    }
  
}
