resource "aws_security_group" "loadBalancerSecurityGroup" {
  name        = "ALBSecurityGroup"
  description = "Controll access to the ALB"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = var.dockerContainerPort
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = var.dockerContainerPort
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALBSecurityGroup"
  }
}