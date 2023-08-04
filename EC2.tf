# Select latest Linux2023 AMI-ID running on 64bit

data "aws_ami" "amzLinux" {
    most_recent = true
    owners = ["amazon"]
        
    filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64*"]
    }
}

# # creates an IAM role

# resource "aws_iam_role" "LabRole" {
#   name = "LabRole"
# }

# # creates an IAM instance profile that will lateron allow us to assign the IAM LabRole to the EC2 instance

# resource "aws_iam_instance_profile" "LabInstanceProfile" {
#   name = "LabInstanceProfile"
#   role = aws_iam_role.LabInstanceProfile.name
# }

data "aws_iam_instance_profile" "LabInstanceProfile" {
  name = "LabInstanceProfile"
}

locals {
        DB      ="mydb"
        User    ="default_user"
        PW      ="password123"
        db-host = aws_db_instance.WordpressDatabase.address
}


# EC2 instance for Wordpress

resource "aws_instance" "Wordpress-instance"{
    depends_on = [aws_db_instance.WordpressDatabase]
    ami = data.aws_ami.amzLinux.id
    instance_type = "t2.micro"
    key_name = "vockey"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_http.id]
    subnet_id = aws_subnet.devVPC_public_subnet1.id
    # assigning the lab role for S3 bucket access
    iam_instance_profile = data.aws_iam_instance_profile.LabInstanceProfile.name
    user_data = base64encode(templatefile("user-data.sh",{
        DB      = local.DB
        User    = local.User
        PW      = local.PW
        db-host    = local.db-host
    }))
    tags = {
        Name = "Wordpress-instance"
    }

#Provides a file with metadata
    provisioner "local-exec"{
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
}