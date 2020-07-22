# Fetch AWS Ubuntu Desktop Jumphost AMI identifier
data "aws_ami" "ubuntu_jumphost" {
  most_recent = true
  owners      = ["self"]
  filter {
    name = "tag:Name"
    values = [
      "ubuntu-jumphost",
    ]
  }
}

