# Firewall for the VPC only allowing ingress and egress on ports 80 (http) and 443 (https) 
# Firewall applies to public subnet 1 and 2

resource "aws_network_acl" "NACL" {
  vpc_id = aws_vpc.devVPC.id
  subnet_ids = [
    "${aws_subnet.devVPC_public_subnet1.id}",
    "${aws_subnet.devVPC_public_subnet2.id}",
  ]

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "NACL"
  }
}