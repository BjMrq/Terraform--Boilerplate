# Define more vpc and subnets here

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
    Application= var.appName
    Environement = var.env
  }
}

resource "aws_default_subnet" "defaultAz1" {
  availability_zone = var.availabilityZone1

  tags = {
    Name = "Default subnet for ${var.availabilityZone1}"
    Application= var.appName
    Environement = var.env
  }
}

resource "aws_default_subnet" "defaultAz2" {
  availability_zone = var.availabilityZone2

  tags = {
    Name = "Default subnet for ${var.availabilityZone2}"
    Application= var.appName
    Environement = var.env
  }
}

resource "aws_db_subnet_group" "RDSSubnet" {
  name       = "rdssubnet"
  subnet_ids = [aws_default_subnet.defaultAz1.id, aws_default_subnet.defaultAz2.id]

  tags = {
    Name         = "Default RDS subnet for ${var.availabilityZone1}"
    Application  = var.appName
    Environement = var.env
  }
}