resource "azurerm_application_gateway" "application_gateways" {
  for_each = var.application_gateways

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  
  sku {
    name     = each.value.name
    tier     = each.value.tier
    capacity = each.value.capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = each.value.gateway_ip_configurations
    content {
        name      = gateway_ip_configuration.key
        subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = each.value.frontend_ports
    content {
        name = frontend_port.key
        port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configurations
    content {
        name                          = frontend_ip_configuration.key
        private_ip_address            = frontend_ip_configuration.value.private_ip_address
        private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
    }
  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_address_pools
    content {
         name         = backend_address_pool.key
         ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings 
    content {
        name                  = backend_http_settings.key
        cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
        path                  = backend_http_settings.value.path
        port                  = backend_http_settings.value.port
        protocol              = backend_http_settings.value.protocol
        request_timeout       = backend_http_settings.value.request_timeout
    }
  }

  dynamic "http_listener" {
    for_each = each.value.http_listeners
    content {
        name                           = http_listener.key
        frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
        frontend_port_name             = http_listener.value.frontend_port_name
        protocol                       = http_listener.value.protocol
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rules
    content {
        name                       = request_routing_rule.key
        priority                   = request_routing_rule.value.priority
        rule_type                  = request_routing_rule.value.rule_type
        http_listener_name         = request_routing_rule.value.http_listener_name
        backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
        backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }
}