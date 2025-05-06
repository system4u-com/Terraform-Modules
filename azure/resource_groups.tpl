name,location,id
%{for key, resource in resources ~}
${resource.name},${resource.location},${resource.id}
%{ endfor ~}