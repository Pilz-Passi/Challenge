# Application Load Balancer in public subnet

resource "aws_lb" "load-balancer" {
  name                              = "Webserver-alb"
  internal                          = false
  load_balancer_type                = "application"
  security_groups                   = [aws_security_group.alb-sg.id]
  subnets                           = [aws_subnet.devVPC_public_subnet1.id, aws_subnet.devVPC_public_subnet2.id]
  enable_deletion_protection        = false
    tags = {
        Environment                 = "production"
  }
}

# pointing to port 80 (http) in the VPC

resource "aws_lb_target_group" "target-group" {
  name                              = "CPUtest-tg"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = aws_vpc.devVPC.id
}

# Listening to port 80 (http)

resource "aws_lb_listener" "listener" {
  load_balancer_arn                 = aws_lb.load-balancer.arn
  port                              = "80"
  protocol                          = "HTTP"
  default_action {
    type                            = "forward"
    target_group_arn                = aws_lb_target_group.target-group.arn
  }
}