

resource "aws_instance" "jumphostn" {
  count                       = var.instance_count
  ami                         = data.aws_ami.ubuntu_jumphost.image_id # eu-west-2
  instance_type               = "t2.large"
  key_name                    = "jumphost-key"
  associate_public_ip_address = true
  security_groups             = [ aws_security_group.jumphostsg.name ]
  #subnet_id                  = aws_subnet.main.id
  #get_password_data          = true
  #private_ip                 = "10.0.0.40"


 
  tags = {
    Name  = "JumpHost-${count.index + 1}"
  }


  
  
}


variable "instance_count" {
  default = "1"
}

#output "dnsname0" { value = "${aws_instance.jumphostn[0].public_dns}" }
#output "dnsname1" { value = "${aws_instance.jumphostn[1].public_dns}" }
#output "dnsname2" { value = "${aws_instance.jumphostn[2].public_dns}" }
#output "dnsname3" { value = "${aws_instance.jumphostn[3].public_dns}" }
#output "dnsname4" { value = "${aws_instance.jumphostn[4].public_dns}" }
#output "dnsname5" { value = "${aws_instance.jumphostn[5].public_dns}" }
#output "dnsname6" { value = "${aws_instance.jumphostn[6].public_dns}" }
#output "dnsname7" { value = "${aws_instance.jumphostn[7].public_dns}" }
#output "dnsname8" { value = "${aws_instance.jumphostn[8].public_dns}" }
#output "dnsname9" { value = "${aws_instance.jumphostn[9].public_dns}" }
#output "dnsname10" { value = "${aws_instance.jumphostn[10].public_dns}" }
#output "dnsname11" { value = "${aws_instance.jumphostn[11].public_dns}" }



#output "connect_to_server_ssh" { value = "\nssh -i ~/.ssh/jumphost-key.pem ubuntu@${aws_instance.jumphostn[0].public_ip}" }


resource "null_resource" "jumphostzero" {
  # Changes to any instance of the cluster requires re-provisioning
  count = var.instance_count
  triggers = {
    trigger1 = aws_instance.jumphostn[count.index].public_dns
  }
  
  provisioner "remote-exec" {
  
    connection {
    type     = "ssh"
    user     = "ubuntu"
	private_key = file("~/.ssh/jumphost-key.pem")
    host     = aws_instance.jumphostn[count.index].public_ip
  }
  
        inline = [

		"sudo echo -e 'ubuntuworkshop\nubuntuworkshop' | (sudo passwd ubuntu)"
		

    ]
  }
}


