# # Has to be delayed for at least 10 Minutes in order to give the original EC2 instance
# # a change to initialize and install the web server
# resource "aws_ami_from_instance" "worpress-image" {
#   name               = "terraform-wordpress-instance"
#   depends_on = Wordpress-instance.id
#   #create a variable, feeding from the output
#   source_instance_id = "i-xxxxxxxx" /*output -raw "instance_id" {
#   value       = aws_instance.Wordpress-instance.id
#     } OR $instance-id OR curl http://169.254.169.254/latest/meta-data/instance-id*/
# }


# Example for delay and timer

# resource "helm_release" "ampa" {
#   name       = "ampa"
#   chart      = "/home/git/ampa/helm-ampa"
#   timeout    = 600

#   namespace = var.namespace
# }

# resource "time_sleep" "wait_for_ingress_alb" {
#   create_duration = "300s"

#   depends_on = [helm_release.ampa]
# }

# data "kubernetes_ingress" "web" {
#   metadata {
#     name      = "votacions-ampa"
#     namespace = var.namespace
#   }

#   time_sleep = [time_sleep.wait_for_ingress_alb]
# }