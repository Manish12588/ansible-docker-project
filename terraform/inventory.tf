resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    instances = {
      for name, inst in aws_instance.my_instance : name => {
        public_ip = inst.public_ip
        user      = var.instances[name].user
        os_family = var.instances[name].os_family
      }
    }
    #ssh_key_path = "${path.module}/ansible-project-key"
    ssh_key_path = coalesce(
      var.controller_key_path,
      "/home/${var.instances["control-node"].user}/keys/ansible-project-key.pem"
    )
  })

  filename        = "${path.module}/../inventory.ini"
  file_permission = "0644"
}
