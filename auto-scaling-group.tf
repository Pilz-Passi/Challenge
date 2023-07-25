resource "aws_autoscaling_group" "auto-scaling-grp" {
  name                              = "my-autoscaling-group"
  max_size                          = 4
  min_size                          = 2
  desired_capacity                  = 2
  vpc_zone_identifier               = [aws_subnet.devVPC_public_subnet1.id, aws_subnet.devVPC_public_subnet2.id]
  target_group_arns                 = [aws_lb_target_group.target-group.arn]
  health_check_type                 = "ELB"
  health_check_grace_period         = 300
  launch_template {
    id                = aws_launch_template.launch-template.id
    version           = "$Latest"
  }
}
resource "aws_autoscaling_policy" "policy" {
  name                              = "CPUpolicy"
  policy_type                       = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type        = "ASGAverageCPUUtilization"
    }
      target_value                  = 70.0
  }
  autoscaling_group_name            = aws_autoscaling_group.auto-scaling-grp.name
}