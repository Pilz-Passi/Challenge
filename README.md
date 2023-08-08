# Challenge
# This is a (constantly) work-in-progress!

Setting up an EC2 instance with WP, using terraform

VPC
Task 1: Create a Virtual private cloud with CIDR 10.0.0.0/16 in the region us-west-2
Task 2: Add 4 subnets - (2 public and 2 private) - 1 public and 1 private in each availability zone
Task 4: Add NAT Gateway (*)
Task 5: Add Internet Gateway
Task 6: Add Routing tables with routes
	Public route table with IGW
	Private route table with NAT gateway(*)
Task 7: Associate routing tables with relevant subnets & verify NACL
Task 8: Add security groups with rules SSH, http traffic originated from <specify CIDR>

EC2 user-data script
Task 1: create a script to perform the following activities: 
Update the Installed packages to the latest version from the repository and install Apache web server, start & enable the service. 
Install MariaDB, start & enable the service
Install Wordpress, start & enable the service
Enable PHP 8.0 and update the system
Make a copy of wp-config-sample.php and rename it to wp-config.php. Configure this file with the latest DB credentials 
Install stress tool 

EC2
Task 1: Request latest AMI-Id for the respective region
Task 2: Create a web server using AWS EC2 service

ALB
Task 1: Create an Application Load Balancer
Task 2: Create a Listener for load balancer along with rule(s) - http
Task 3: Create a Target Group
Task 4: Register Targets 
Task 5: Create a security group for Load Balancer

ASG
Task 2: Launch Template
Task 3: Create an Auto Scaling Group
Task 4: Specify capacity(min,max, desired)
Task 5: Add Health checks
Task 6: Configure Auto Scaling Policy - Target Tracking Policy? 
Task 7: Associate the application load balancer with this ASG

SNS
Task 1: Add cloudwatch metrics with CPU utilization & threshold configured. 
Task 2: Add a cloudwatch alarm based on above configuration
Task 3: Add SNS topic  
Task 4: Create subscription to the SNS topic with protocol - Email
