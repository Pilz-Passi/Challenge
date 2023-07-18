/*data "aws_ami" "amzLinux" {
        most_recent = true
        owners = ["amazon"]
    }
*/
resource "aws_instance" "Wordpress-instance"{
    ami = "ami-0ae49954dfb447966"
    instance_type = "t3.micro"
    key_name = "vockey"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_http.id]
    subnet_id = aws_subnet.devVPC_public_subnet1.id
    user_data = "${file("init.tpl")}"
    tags = {
        Name = "Wordpress-instance"
    }
}