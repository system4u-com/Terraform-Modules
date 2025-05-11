locals {
  network_security_rules_flattened = flatten([
    for instance_key, instance_value in var.network_security_groups : [
      for rule_key, rule_value in lookup(instance_value, "rules", {}) : {
        key                          = "${instance_key}-${rule_key}"
        name                         = "${rule_key}"
        resource_group_name          = "${instance_value.resource_group.name}"
        network_security_group_name  = "${instance_key}"
      }
    ]
  ])
}