resource "aws_key_pair" "my_key_pair" {
  key_name   = "ansible-project-key"
  public_key = file("${path.module}/ansible-project-key.pub")
}