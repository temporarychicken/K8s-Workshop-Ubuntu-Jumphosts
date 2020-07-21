resource "aws_security_group" "jumphostsg" {
  name        = "jumphosts"
  description = "Allow RDP,TLS,HTTP,SSH inbound traffic"
  #vpc_id      = aws_vpc.main.id


  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "VNC"
    from_port   = 5900
    to_port     = 5905
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  ingress {
    description = "K8S API Server HTTPS"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  ingress {
    description = "K8S Dashboard HTTPS"
    from_port   = 32443
    to_port     = 32443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  ingress {
    description = "K8S NGINX PLUS Ingress Controller"
    from_port   = 31443
    to_port     = 31443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
   ingress {
    description = "Ingress Traffic HTTP"
    from_port   = 32080
    to_port     = 32080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Intra-cluster traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/24"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "JumpHostSG"
  }
}
