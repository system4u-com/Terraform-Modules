# Terraform-Modules

Reusable Terraform modules for Azure resources, organized by service area. Each
top-level directory is a standalone module; resources are created via input maps
defined in the corresponding `*.variables.tf` files. Empty maps result in no
resources being created.

## Requirements

- Terraform (no `required_version` is declared in this repo)
- AzureRM provider (see each module's `terraform.tf`, e.g. `azurerm ~> 4.27.0`)

## Module Catalog

- `az`: resource groups, user-assigned identities, resource provider registrations, marketplace agreements
- `az_app_service`: service plans, Linux Function Apps (flex function app variables scaffold only)
- `az_automation`: automation accounts, runbooks, schedules
- `az_avd`: AVD workspaces, host pools, app groups, hosts, scaling plans
- `az_compute`: virtual machines (Linux/Windows), managed disks, VM extensions
- `az_container`: container app environments, container app jobs
- `az_key_vault`: key vaults
- `az_monitoring`: log analytics workspaces, action groups, metric alerts, diagnostic settings, scheduled query rules, data collection rules
- `az_network`: virtual networks, subnets, NSGs, NICs, public IPs, route tables, gateways, peering, express route, application gateways
- `az_recovery_services`: recovery services vaults
- `az_storage`: storage accounts, shares, sync, sync groups

## Usage

Use a module by pointing Terraform to the directory and setting the appropriate
input map. Refer to each module's `*.variables.tf` for the exact schema.

```hcl
module "core" {
  source = "./az"

  resource_groups = {
    rg-app = {
      location = "westeurope"
      tags     = { environment = "dev" }
    }
  }
}
```

```hcl
module "network" {
  source = "./az_network"

  virtual_networks = {
    vnet-main = {
      resource_group = {
        id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-app"
        name     = "rg-app"
        location = "westeurope"
      }
      address_space = ["10.0.0.0/16"]
      tags          = { environment = "dev" }
    }
  }
}
```

## Notes

- Most resources use `for_each` over map variables; defaults are empty maps.
- Some modules include shared `variables.tf` and `outputs.tf` for convenience.
