resource "aws_db_instance" "WordpressDatabase" {
  depends_on             = [aws_security_group.devVPC_sg_allow_http, aws_instance.Wordpress-instance]
  identifier             = "${var.identifier}"
  allocated_storage      = "${var.storage}"
  engine                 = "${var.engine}"
  engine_version         = "${lookup(var.engine_version, var.engine)}"
  instance_class         = "${var.instance_class}"
  db_name                = "${var.db_name}"
  username               = "${var.username}"
  password               = "${var.password}"
  vpc_security_group_ids = ["${aws_security_group.rds-sg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.private-sub-group.id
  skip_final_snapshot = true
}