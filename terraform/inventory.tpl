[control]
%{ for name, inst in instances ~}
%{ if name == "control-node" ~}
${inst.public_ip} ansible_user=${inst.user} ansible_ssh_private_key_file=${ssh_key_path}
%{ endif ~}
%{ endfor ~}

[webservers]
%{ for name, inst in instances ~}
%{ if name == "web-server" ~}
${inst.public_ip} ansible_user=${inst.user} ansible_ssh_private_key_file=${ssh_key_path}
%{ endif ~}
%{ endfor ~}

[appservers]
%{ for name, inst in instances ~}
%{ if name == "app-server" ~}
${inst.public_ip} ansible_user=${inst.user} ansible_ssh_private_key_file=${ssh_key_path}
%{ endif ~}
%{ endfor ~}

[dbservers]
%{ for name, inst in instances ~}
%{ if name == "db-server" ~}
${inst.public_ip} ansible_user=${inst.user} ansible_ssh_private_key_file=${ssh_key_path}
%{ endif ~}
%{ endfor ~}

[servers:children]
webservers
appservers
dbservers

[servers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_host_key_checking=False