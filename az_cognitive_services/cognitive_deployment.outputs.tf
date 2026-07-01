output "cognitive_deployments" {
  value = {
    for k, value in azurerm_cognitive_deployment.cognitive_deployments : k => {
      id   = value.id
      name = value.name
    }
  }
}
