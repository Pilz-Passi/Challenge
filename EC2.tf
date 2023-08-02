data "aws_ami" "amzLinux" {
    most_recent = true
    owners = ["amazon"]
        
    filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64*"]
    }
}
resource "aws_instance" "Wordpress-instance"{
    ami = data.aws_ami.amzLinux.id
    instance_type = "t3.micro"
    key_name = "vockey"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_http.id]
    subnet_id = aws_subnet.devVPC_public_subnet1.id
    user_data = "${file("init.tpl")}"
    tags = {
        Name = "Wordpress-instance"
    }

#Provides a file with metadata
    provisioner "local-exec"{
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
}