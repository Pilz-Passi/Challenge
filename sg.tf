resource "aws_security_group" "devVPC_sg_allow_http"{
    vpc_id = aws_vpc.devVPC.id
    name = "devVPC_terraform_vpc_allow_http"
    tags = {
        Name = "devVPC_terraform_sg_allow_http"
    }
}
# Ingress Security Port 22 (Inbound) SSH, for monitoring reasons
resource "aws_security_group_rule" "devVPC_http_ingress_access"{
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
# Ingress Security Port 8080 (Inbound)
resource "aws_security_group_rule" "devVPC_http8080_ingress_access"{
    from_port = 8080
    protocol = "tcp"
    security_group_id = aws_security_group.devVPC_sg_allow_http.id
    to_port= 8080
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}
# Egress Security all traffic (Outbound), so installations are possible
resource "aws_security_group_rule" "devVPC_all_traffic_egress_access"{
    from_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.devVPC_sg_allow_http.id
    to_port= 0
    type = "egress"
    cidr_blocks = [var.cidr_blocks]
    }