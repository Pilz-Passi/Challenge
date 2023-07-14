variable "AWS_REGION"{
    default="us-west-2"
    description="AWS Region"
}

variable "cidr_blocks"{
    default = "0.0.0.0/0"
}

variable "private_cidr"{
    default = "10.0.1.16/28"
}

