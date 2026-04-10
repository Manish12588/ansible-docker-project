# ------- Install Ansible on Controler node -----#
resource "null_resource" "setup_controller" {
  depends_on = [local_file.ansible_inventory]

  #Create keys directory on controller
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/keys"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/ansible-project-key")
      host        = aws_instance.my_instance["control-node"].public_ip
    }
  }

  #Copy Private key to controler node
  provisioner "file" {
    source      = "${path.module}/ansible-project-key"
    destination = "/home/ubuntu/keys/ansible-project-key"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/ansible-project-key")
      host        = aws_instance.my_instance["control-node"].public_ip
    }
  }

  #Install ansible on controler node
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/keys/ansible-project-key",
      "sudo apt-add-repository ppa:ansible/ansible -y",
      "sudo apt update -y ",
      "sudo apt install ansible -y",
      "ansible --version"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/ansible-project-key")
      host        = aws_instance.my_instance["control-node"].public_ip
    }
  }

}
