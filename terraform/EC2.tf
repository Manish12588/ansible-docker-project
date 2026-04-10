resource "aws_instance" "my_instance" {

  for_each               = var.instances                             # Total given 4 instances
  ami                    = each.value.ami                            # Get the AMI value of each instances
  instance_type          = each.value.instance_type                  # Instance Type
  key_name               = aws_key_pair.my_key_pair.key_name         # Key pair
  vpc_security_group_ids = [aws_security_group.my_security_group.id] # VPC & Security Group

  # root storage (EBS)
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name     = each.key
    OSFamily = each.value.os_family
  }
}