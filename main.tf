provider "aws"{
    region = var.AWS_REGION
}
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> v1.5.2"
        }
    }
}