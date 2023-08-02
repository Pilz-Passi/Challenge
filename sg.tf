# Security Group EC2 Wordpress

resource "aws_security_group" "devVPC_sg_allow_http"{
    vpc_id = aws_vpc.devVPC.id
    name = "devVPC_terraform_vpc_allow_http"
    tags = {
        Name = "devVPC_terraform_sg_allow_http"
    }
}

    # Ingress Security Port 22 (Inbound) SSH, for monitoring reasons
    resource "aws_security_group_rule" "devVPC_http_ingress22_access"{
        from_port = 22
        protocol = "tcp"
        security_group_id = aws_security_group.devVPC_sg_allow_http.id
        to_port= 22
        type = "ingress"
        cidr_blocks = [var.cidr_blocks]
    }

    # Ingress Security Port 80 (Inbound)
    resource "aws_security_group_rule" "devVPC_http_ingress_access"{
        from_port = 80
        protocol = "tcp"
        security_group_id = aws_security_group.devVPC_sg_allow_http.id
        to_port= 80
        type = "ingress"
        cidr_blocks = [var.cidr_blocks]
    }

    # Egress All (Outbound)
    resource "aws_security_group_rule" "devVPC_all_traffic_egress_access"{
        from_port = 0
        protocol = "-1"
        security_group_id = aws_security_group.devVPC_sg_allow_http.id
        to_port= 0
        type = "egress"
        cidr_blocks = [var.cidr_blocks]
    }

# Autoscaling Security Group

resource "aws_security_group" "autoscaling-sg"{
    vpc_id                      = aws_vpc.devVPC.id
    name                        = "autoscaling-sg"
    tags = {
        Name = "autoscaling-sg"
    }
}

    # Autoscaling rule ingress port 80 (http)

    resource "aws_security_group_rule" "autoscaling-sg-in"{
        from_port                   = 80
        protocol                    = "tcp"
        security_group_id           = aws_security_group.autoscaling-sg.id
        to_port                     = 80
        type                        = "ingress"
        cidr_blocks                 = [var.cidr_blocks]
    }

    # Autoscaling rule ingress port 22 (SSH)

    resource "aws_security_group_rule" "autoscaling-sg-in"{
        from_port                   = 22
        protocol                    = "tcp"
        security_group_id           = aws_security_group.autoscaling-sg.id
        to_port                     = 22
        type                        = "ingress"
        cidr_blocks                 = [var.cidr_blocks]
    }

    # Autoscaling rule ingress port 3306 (RDS)

    resource "aws_security_group_rule" "autoscaling-sg-in"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.autoscaling-sg.id
        to_port                     = 3306
        type                        = "ingress"
        cidr_blocks                 = [var.cidr_blocks]
    }

    # Autoscaling rule ingress 3306 (MySQL)

    resource "aws_security_group_rule" "mysql-sg-autoscaling-in"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.rds-sg.id
        to_port                     = 3306
        type                        = "ingress"
        source_security_group_id    = aws_security_group.autoscaling-sg.id
    }

    # Autoscaling rule egress 3306 (MySQL)

    resource "aws_security_group_rule" "mysql-sg-autoscaling-out"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.rds-sg.id
        to_port                     = 3306
        type                        = "egress"
        source_security_group_id    = aws_security_group.autoscaling-sg.id
    }

    # Autoscaling rule egress all (Outbound)

    resource "aws_security_group_rule" "autoscaling-sg-out"{
        from_port                   = 0
        protocol                    = "all"
        security_group_id           = aws_security_group.autoscaling-sg.id
        to_port                     = 65535
        type                        = "egress"
        cidr_blocks                 = [var.cidr_blocks]
    }

# Security Group (Application-)Load-Balancer

resource "aws_security_group" "alb-sg"{
    vpc_id                      = aws_vpc.devVPC.id
    name                        = "alb-sg"
    tags = {
        Name = "alb-sg"
    }
}

    # Load Balancer rule ingress 80 (http)

    resource "aws_security_group_rule" "alb-sg-http-in"{
        from_port                   = 80
        protocol                    = "tcp"
        security_group_id           = aws_security_group.alb-sg.id
        to_port                     = 80
        type                        = "ingress"
        cidr_blocks                 = [var.cidr_blocks]
    }

    # Load Balancer rule ingress 443 (hhtps)

    resource "aws_security_group_rule" "alb-sg-http-in"{
        from_port                   = 443
        protocol                    = "tcp"
        security_group_id           = aws_security_group.alb-sg.id
        to_port                     = 443
        type                        = "ingress"
        cidr_blocks                 = [var.cidr_blocks]
    }

    # Load Balancer rule egress all (Outbound)

    resource "aws_security_group_rule" "alb-sg-tcp-out"{
        from_port                   = 0
        protocol                    = "all"
        security_group_id           = aws_security_group.alb-sg.id
        to_port                     = 65535
        type                        = "egress"
        cidr_blocks                 = [var.cidr_blocks]
    }

# RDS MySQL Security Group

resource "aws_security_group" "rds-sg"{
    vpc_id                      = aws_vpc.devVPC.id
    name                        = "rds-sg"
    tags = {
        Name = "rds-sg"
    }
}

    # RDS MySQL rule ingress 3306 (MySQL)

    resource "aws_security_group_rule" "rds-sg-in"{
        from_port                   = 3306
        protocol                    = "tcp"
        security_group_id           = aws_security_group.rds-sg.id
        to_port                     = 3306
        type                        = "ingress"
        cidr_blocks                 = [var.cidr_blocks]
    }

    # resource "aws_security_group_rule" "rds-sg-out"{
    #     from_port                   = 3306
    #     protocol                    = "tcp"
    #     security_group_id           = aws_security_group.rds-sg.id
    #     to_port                     = 3306
    #     type                        = "egress"
    #     cidr_blocks                 = [var.cidr_blocks]
    # }