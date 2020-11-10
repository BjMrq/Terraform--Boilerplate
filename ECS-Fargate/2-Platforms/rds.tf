resource "aws_db_instance" "RDS" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgresql"
  engine_version       = "11.5"
  instance_class       = "db.t2.micro"
  name                 = "${var.appName}RDS"
  username             = var.dbUser
  password             = var.dbPassword
  vpc_security_group_ids = ["value"]

  tags = {
    Application = var.appName
    Environement = var.env
  }

}


# resource "aws_db_subnet_group" "dbsubnet" {
#   name       = "main"
#   subnet_ids = ["${aws_subnet.sub1.id}"]
# }