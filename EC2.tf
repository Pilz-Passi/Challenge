resource "aws_instance" "Wordpress-instance"{
    ami = "ami-0ae49954dfb447966"
    instance_type = "t3.micro"
    key_name = "vockey"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_http.id]
    subnet_id = aws_subnet.devVPC_public_subnet1.id
    tags = {
        Name = "Wordpress-instance"
    }
data "template_file" "init" {
  template = "${file("${path.module}/init.tpl")}"
  vars = {
    consul_address = "${aws_instance.consul.private_ip}"
  }
}
/*     #install all neccecary services for worpress
    provisioner "remote-exec"{
        inline = [
            "sudo yum update -y",
            "sudo yum install -y nginx",
            "sudo service nginx start"
            "sudo dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel"
            "sudo dnf install mariadb105-server"
            "sudo systemctl start mariadb"
            "sudo mysql_secure_installation"
            "wget https://wordpress.org/latest.tar.gz"
            "tar -xzf latest.tar.gz"
        ]
        on_failure = continue
    }*/
    provisioner "local-exec"{
    command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
  }
}