# Define more vpc and subnets here

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "defaultAz1" {
  availability_zone = var.availabilityZone1

  tags = {
    Name = "Default subnet for ${var.availabilityZone1}"
  }
}

resource "aws_default_subnet" "defaultAz2" {
  availability_zone = var.availabilityZone2

  tags = {
    Name = "Default subnet for ${var.availabilityZone2}"
  }
}