resource "aws_key_pair" "jumphost-key" {
  key_name   = "jumphost-key"
  public_key = file ("~/.ssh/jumphost-key.pub")
}

