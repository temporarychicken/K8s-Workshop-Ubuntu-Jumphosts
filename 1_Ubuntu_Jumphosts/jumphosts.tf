

resource "aws_instance" "jumphostn" {
  count         = "${var.instance_count}"
  ami                         = "ami-006a0174c6c25ac06" # eu-west-2
  instance_type               = "t2.medium"
  key_name                    = "jumphost-key"
  associate_public_ip_address = true
  security_groups             = [ aws_security_group.jumphostsg.name ]
  #subnet_id                   = aws_subnet.main.id
  #get_password_data           = true
  #private_ip                  = "10.0.0.40"


 
  tags = {
    Name  = "JumpHost-${count.index + 1}"
  }


  
  
}


variable "instance_count" {
  default = "2"
}

output "dnsname0" {
  value = "${aws_instance.jumphostn[0].public_dns}"
}
  output "dnsname1" {
  value = "${aws_instance.jumphostn[1].public_dns}"
}  





resource "null_resource" "jumphostzero" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    trigger1 = aws_instance.jumphostn[0].public_dns
  }
  
  provisioner "remote-exec" {
  
    connection {
    type     = "ssh"
    user     = "ubuntu"
	private_key = file("jumphosts")
    host     = aws_instance.jumphostn[0].public_ip
  }
  
        inline = [
		"until sudo apt-get upgrade -y; do sleep 10; done",
	    "until sudo apt-get update -y; do sleep 10; done",
		"#sudo apt install ubuntu-desktop -y",
        "#sudo apt install tightvncserver -y",
        "#sudo apt install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal -y",
		
		"sudo apt install xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils -y",
		"sudo apt install xrdp -y",
		"sudo systemctl status xrdp -y",
		"sudo adduser xrdp ssl-cert -y",
		"sudo systemctl restart xrdp",
		"sudo ufw allow 3389",
		"echo -e 'ubuntu\nubuntu' | (sudo passwd ubuntu)",
		"wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb",
        "until sudo apt-get update -y; do sleep 10; done",
		"sudo apt install ./google-chrome-stable_current_amd64.deb -y",
		"echo -e 'ubuntu\nubuntu' | sudo passwd ubuntu",
		"sudo apt-get install ansible -y",
		"ansible-galaxy install nginxinc.nginx",
		"sudo apt-get install aws -y"
    ]
  }
}


