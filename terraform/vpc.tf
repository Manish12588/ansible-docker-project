# VPC Default
resource "aws_default_vpc" "default" {
}

# Security Group 
resource "aws_security_group" "my_security_group" {

  name        = "ansible-project-security-group"
  vpc_id      = aws_default_vpc.default.id              #interpolation
  description = "this is Inbound and outbound rules for your instance Security group"

}

# Inbound & Outbount port rules
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"                      # semantically equivalent to all ports
}
