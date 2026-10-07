# Azure Private DNS module

This module manages multiple Azure Private DNS zones, virtual network links, and
A, AAAA, CNAME, and TXT record sets.

Zone map keys are logical identifiers. Records and virtual network links refer to
a zone using `zone_key`.

## Example

```hcl
module "private_dns" {
  source = "./az_private_dns"

  private_dns_zones = {
    blob = {
      name = "privatelink.blob.core.windows.net"

      resource_group = {
        id   = module.core.resource_groups["rg-network"].id
        name = module.core.resource_groups["rg-network"].name
      }
    }
  }

  private_dns_zone_virtual_network_links = {
    app = {
      zone_key            = "blob"
      virtual_network_id   = module.network.virtual_networks["app"].id
      registration_enabled = false
    }
  }

  private_dns_records = {
    storage = {
      zone_key = "blob"
      type     = "A"
      name     = "storage"
      records  = ["10.10.1.10"]
    }

    storage_alias = {
      zone_key = "blob"
      type     = "CNAME"
      name     = "storage-alias"
      record   = "storage.privatelink.blob.core.windows.net"
    }
  }
}
```

## Managed and existing zones

Zones can be created by the module with `private_dns_zones` or looked up with
`unmanaged_private_dns_zones`. Both use the same `zone_key` reference mechanism
for links and records.

```hcl
unmanaged_private_dns_zones = {
  shared = {
    name                = "privatelink.database.windows.net"
    resource_group_name = "rg-shared-network"
  }
}
```

Do not reuse the same key in `private_dns_zones` and
`unmanaged_private_dns_zones`.

## Record values

The provider exposes different resources for each DNS record type. The module
provides one input map and selects the provider resource based on `type`:

- `A`, `AAAA`, and `TXT` use `records = list(string)`.
- `CNAME` uses `record = string`.
- `ttl` defaults to `300` seconds.
- Record types are case-insensitive.

A DNS record set is identified by its zone, name, and type. Multiple IP
addresses for one A or AAAA record set belong in one `records` list.

The module currently supports `A`, `AAAA`, `CNAME`, and `TXT`. MX, PTR, and SRV
records are not part of the first version.
