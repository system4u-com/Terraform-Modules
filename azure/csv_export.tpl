resource_type,name,resource_group,parent_resource,location,id
%{for key, rg in resource_groups ~}
resource group,${rg.name},N/A,N/A,${rg.location},${rg.id}
%{ endfor ~}
%{for key, vnet in virtual_networks ~}
virtual network,${vnet.name},${vnet.resource_group_name},N/A,${vnet.location},${vnet.id}
%{ endfor ~}