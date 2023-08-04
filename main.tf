# Making sure we're using only up to and including version 5.8.0 and all of the below.
# This is to make sure Code stay congruent to all used modules.

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.8.0"
        }
    }
}

# Key element, that tells terraform, that this is AWS Code

provider "aws"{
    region = var.AWS_REGION
}