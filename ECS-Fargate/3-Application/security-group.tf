resource "aws_security_group" "serviceSecurityGroup" {
  name        = "${var.serviceName}SecurityGroup"
  description = "Security for ${var.serviceName} group to communicate in and out"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = var.dockerContainerPort
    protocol    = "TCP"
    to_port     = var.dockerContainerPort
    cidr_blocks = [aws_default_vpc.default.cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.serviceName}SecurityGroup"
  }
}