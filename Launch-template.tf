resource "aws_launch_template" "launch-template" {
    name                              = "webserver-launch-template"
    image_id                          = data.aws_ami.amzLinux.id
    instance_type                     = "t2.micro"
    vpc_security_group_ids            = [aws_security_group.autoscaling-sg.id]
    user_data                         = "${file("stresstest.sh")}"
    tag_specifications {
        resource_type = "instance"
        tags          = {
            Name      = "autoserver"
        }
    }
}