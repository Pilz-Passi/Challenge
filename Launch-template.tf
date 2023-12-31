# Creates a launch template, which is being used by the Autoscaling group.
# For now it will install the stresstest tool, to be able to manually trigger the scale out.
# Later it will use the user-data, which installs wordpress.

resource "aws_launch_template" "launch-template" {
    name                              = "webserver-launch-template"
    image_id                          = data.aws_ami.amzLinux.id
    instance_type                     = "t2.micro"
    vpc_security_group_ids            = [aws_security_group.autoscaling-sg.id]
    user_data                         = filebase64("stresstest.sh")
        depends_on = [ aws_db_instance.WordpressDatabase ]
    tag_specifications {
        resource_type = "instance"
        tags          = {
            Name      = "autoserver"
        }
    }
}