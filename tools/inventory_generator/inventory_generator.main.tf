locals {
  vms = values(merge(
    try(var.az_compute.linux_vms, {}),
    try(var.az_compute.windows_vms, {}),
    try(var.az_compute.virtual_machines, {})
  ))

  # Normalize each VM and parse group list from configurable tag
  vms_parsed = [
    for vm in local.vms : {
      name    = vm.name

      # parse tag: "web, db,monitoring" -> ["web","db","monitoring"]
      groups = distinct(compact([
        for g in split(",", try(vm.tags[var.ansible_groups_tag], "")) : trimspace(g)
      ]))
    }
    # keep only VMs that have at least 1 group
    if length(distinct(compact([for g in split(",", try(vm.tags[var.ansible_groups_tag], "")) : trimspace(g)]))) > 0
  ]

  # Flatten (group, host) pairs so a host can be in multiple groups
  group_host_pairs = flatten([
    for vm in local.vms_parsed : [
      for g in vm.groups : {
        group   = g
        name    = vm.name
      }
    ]
  ])

  # Build group => list(hosts)
  ansible_groups = {
    for g in distinct([for p in local.group_host_pairs : p.group]) :
    g => [
    for p in local.group_host_pairs : {
      name    = p.name
    } if p.group == g
  ]
  }
}

resource "local_file" "ansible_inventory_yaml" {
  filename = coalesce(var.output_path, "${path.root}/hosts.generated.yml")
  content  = templatefile("${path.module}/inventory.yml.tftpl", {
    groups = local.ansible_groups
  })
}
