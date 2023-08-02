variable "AWS_REGION"{
    default="us-west-2"
    description="AWS Region"
}

variable "cidr_blocks"{
    default = "0.0.0.0/0"
}

variable "cidr_block_dev_vpc" {
    default = "10.0.0.0/16"
}

variable "cidr_block_public_subnet1" {
    default = "10.0.1.0/24"
}

variable "cidr_block_public_subnet2" {
    default = "10.0.3.0/24"
}

variable "cidr_block_private_subnet1" {
    default = "10.0.2.0/24"
}

variable "cidr_block_private_subnet2" {
     default = "10.0.4.0/24"
}

variable "identifier" {
  default     = "mydb-rds"
  description = "Identifier for your DB"
}

variable "storage" {
  default     = "10"
  description = "Storage size in GB"
}

variable "engine" {
  default     = "mysql"
  description = "Engine type, here it is mysql"
}

variable "engine_version" {
  description = "Engine version"

  default = {
    mysql    = "5.7"
  }
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "mydb"
  description = "db name"
}

variable "username" {
  default     = "default_user"
  description = "User name"
}

variable "password" {
  description = "password, provide through your ENV variables"
  default = "password123"
}

variable "subnet_1_cidr" {
  default     = "172.31.48.0/20"
  description = "Your AZ"
}

variable "subnet_2_cidr" {
  default     = "172.31.64.0/20"
  description = "Your AZ"
}

variable "az_1" {
  default     = "eu-west-3c"
  description = "Your Az1, use AWS CLI to find your account specific"
}

variable "az_2" {
  default     = "eu-west-3a"
  description = "Your Az2, use AWS CLI to find your account specific"
}

variable "vpc_id" {
  description = "Your VPC ID"
  default = "vpc-be1010d7"
}

variable "sg_name" {
  default     = "my-rds-sg"
  description = "Tag Name for sg"
}