output "container_app_jobs" {
    value = {
        for name, env in azurerm_container_app_job.container_app_jobs :
        name => {
            id = env.id
            name = env.name
            location = env.location
            resource_group_name = env.resource_group_name
            tags = env.tags
        }
    }
  
}
