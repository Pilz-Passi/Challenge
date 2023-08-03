output "instance_id" {
    value = aws_instance.Wordpress-instance.id
}
# output "ami_id" {
#     value = aws_ami_from_instance.Wordpress-instance.id
# }
output "vpc_id"{
    value = aws_vpc.devVPC.id    
}
output "aws_internet_gateway"{
    value = aws_internet_gateway.devVPC_IGW.id
}
output "public_subnet1"{
    value = aws_subnet.devVPC_public_subnet1.id 
}    
output "public_subnet2"{
    value = aws_subnet.devVPC_public_subnet2.id 
}
output "security_group"{
    value = aws_security_group.devVPC_sg_allow_http.id
}
output "ec2_public_ip"{
    value = aws_instance.Wordpress-instance.public_ip   
}
output "name" {
  value = aws_lb.load-balancer.dns_name
}
/*output "packer_ami"{
    value= data.aws_ami.packeramisjenkins.id
}
output "aws_instance"{
    value=aws_instance.jenkins-instance.id
}
# For more attributes https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference
output "public_ip"{
    value = aws_instance.jenkins-instance.public_ip
}
output "public_dns"{
    value = aws_instance.jenkins-instance.public_dns
}*/