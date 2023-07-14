#test1
provider "aws"{
    region = var.AWS_REGION
}

/*
resource "aws_instance" "deham6demo"{
    ami = "ami-0fa167c2af1ea0840"
    instance_type = "t3.micro"
    key_name = "vockey"
    vpc_security_group_ids = ["sg-0acaa46ca7912ea65"]
    subnet_id = "subnet-0cd64936af6fd342a"
    tags = {
        Name = "deham6demo"
    }
}*/
