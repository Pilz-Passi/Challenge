# data "aws_launch_template" "default" {
#   name = "my-launch-template"
# }
# resource "aws_launch_configuration" "nginx_launch_config"{
#     image_id = data.aws_ami.packeramisnginx.id
#     instance_type = var.instance_type
#     security_groups = [aws_security_group.devVPC_sg_allow_ssh_http.id]
#     user_data = data.template_file.init.rendered
#     lifecycle {      
#       create_before_destroy = true
#     }    
# }
# resource "aws_autoscaling_group" "nginx_autoscaling_group"{
#     launch_configuration = aws_launch_configuration.nginx_launch_config.id
#     vpc_zone_identifier = [aws_subnet.devVPC_public_subnet.id]
#     health_check_type = "ELB"
#     min_size = 2
#     max_size = 5
#     load_balancers = [aws_elb.nginx-elb.id]
#     tag{
#         key = "Name"
#         value = "dev_terraform_nginx_instance_asg"
#         propagate_at_launch = true
#     }
# }
# resource "aws_autoscaling_policy" "nginx_cpu_policy_scaleup"{
#     name = "nginx_cpu_policy_scaleup"
#     autoscaling_group_name = aws_autoscaling_group.nginx_autoscaling_group.name
#     adjustment_type = "ChangeInCapacity"
#     scaling_adjustment = 1
#     cooldown="120"
# }
# resource "aws_autoscaling_policy" "nginx_cpu_policy_scaledown"{
#     name = "nginx_cpu_policy_scaledown"
#     autoscaling_group_name = aws_autoscaling_group.nginx_autoscaling_group.name
#     adjustment_type = "ChangeInCapacity"
#     scaling_adjustment = -1
#     cooldown="120"
# }
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.devVPC_sg_allow_http.id] # devVPC_sg_allow_http
  subnets            = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id] # private_subnet1 private_subnet2

  #enable_deletion_protection = false

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "production"
  }
}
# resource "aws_launch_template" "foobar" {
#   name_prefix   = "foobar"
#   image_id      = "ami-1a2b3c"
#   instance_type = "t2.micro"
# }
# data "aws_autoscaling_group" "foo" {
#   name = "foo"
# }
# resource "aws_autoscaling_group" "bar" {
#   availability_zones = ["us-east-1a"]
#   desired_capacity   = 1
#   max_size           = 1
#   min_size           = 1

#   launch_template {
#     id      = aws_launch_template.foobar.id
#     version = "$Latest"
#   }
# }