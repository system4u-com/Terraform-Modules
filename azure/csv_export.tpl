resource_type,name,resource_group,parent_resource,location,id

%{~ for key, value in resource_groups ~}
resource group,${value.name},n/a,n/a,${value.location},${value.id}
%{ endfor ~}

%{~ for key, value in virtual_networks ~}
virtual network,${value.name},${value.resource_group_name},n/a,${value.location},${value.id}
%{ endfor ~}

%{~ for key, value in subnets ~}
subnet,${value.name},${value.resource_group_name},${value.virtual_network_name},inherited,${value.id}
%{ endfor ~}

%{~ for key, value in peerings ~}
peering,${value.name},${value.resource_group_name},${value.virtual_network_name},inherited,${value.id}
%{ endfor ~}

%{~ for key, value in public_ips ~}
public ip,${value.name},${value.resource_group_name},n/a,${value.location},${value.id}
%{ endfor ~}

%{~ for key, value in network_security_groups ~}
network security group,${value.name},${value.resource_group_name},n/a,${value.location},${value.id}
%{ endfor ~}

%{~ for key, value in network_security_rules ~}
network security rule,${value.name},${value.resource_group_name},${value.network_security_group_name},inherited,inline
%{ endfor ~}

%{~ for key, value in network_interfaces ~}
network interface,${value.name},${value.resource_group_name},n/a,${value.location},${value.id}
%{ endfor ~}