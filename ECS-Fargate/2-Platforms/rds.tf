resource "aws_db_instance" "RDS" {
  name = "${var.appName}RDS"

  engine            = "postgres"
  storage_type      = "gp2"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  port     = 5432
  username = var.dbUser
  password = var.dbPassword

  skip_final_snapshot             = true
  publicly_accessible             = true
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  db_subnet_group_name   = aws_db_subnet_group.RDSSubnet.name
  vpc_security_group_ids = [aws_security_group.RDSSecurityGroup.id]

  tags = {
    Application  = var.appName
    Environement = var.env
  }
}


resource "aws_security_group" "RDSSecurityGroup" {
  name        = "RDSSecurityGroup"
  description = "Controll access to the RDS"
  vpc_id      = aws_default_vpc.default.id

  // Access from from controlled ip
  ingress {
    from_port   = 5432
    protocol    = "TCP"
    to_port     = 5432
    cidr_blocks = [var.rdsCidrAccess]
  }

  // Acces from application
  ingress {
    from_port   = 5432
    protocol    = "TCP"
    to_port     = 5432
    cidr_blocks = [[
    data.terraform_remote_state.infrastructure.outputs.defaultAz1Cidr,
    data.terraform_remote_state.infrastructure.outputs.defaultAz2Cidr
  ]]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "RDSSecurityGroup"
    Application  = var.appName
    Environement = var.env
  }
}