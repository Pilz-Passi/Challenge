# # Has to be delayed for at least 10 Minutes in order to give the original EC2 instance
# # a change to initialize and install the web server
# resource "aws_ami_from_instance" "worpress-image" {
#   name               = "terraform-wordpress-instance"
#   #create a variable, feeding from the output
#   source_instance_id = "i-xxxxxxxx" /*output -raw "instance_id" {
#   value       = aws_instance.Wordpress-instance.id
#     } OR $instance-id OR curl http://169.254.169.254/latest/meta-data/instance-id*/
# }