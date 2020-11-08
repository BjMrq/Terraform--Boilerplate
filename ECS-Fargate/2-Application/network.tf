resource "aws_security_group" "loadBalancerSecurityGroup" {
  name        = "ALBSecurityGroup"
  description = "Controll access to the ALB"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.VPCdefaultId

  ingress {
    from_port   = 80
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

resource "aws_security_group" "serviceSecurityGroup" {
  name        = "${var.serviceName}SecurityGroup"
  description = "Security for ${var.serviceName} group to communicate in and out"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.VPCdefaultId

  ingress {
    from_port   = var.dockerContainerPort
    protocol    = "TCP"
    to_port     = var.dockerContainerPort
    cidr_blocks = [data.terraform_remote_state.infrastructure.outputs.VPCdefaultCidr]
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

resource "aws_alb_target_group" "ecsBackendTargetGroup" {
  name        = "${var.serviceName}TagetGroup"
  port        = var.dockerContainerPort
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.VPCdefaultId
  target_type = "ip"

  health_check {
    path                = ""
    protocol            = "HTTP"
    interval            = 60
    timeout             = 30
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }

  tags = {
    Name = "${var.serviceName}TagetGroup"
  }

  depends_on = [aws_alb.ecsAppLoadBalancer]
}


resource "aws_alb" "ecsAppLoadBalancer" {
  name = "${var.ecsClusterName}ALB"

  internal     = false
  enable_http2 = true

  security_groups = [aws_security_group.loadBalancerSecurityGroup.id]
  subnets = [
    data.terraform_remote_state.infrastructure.outputs.subnetDefaultAz1,
    data.terraform_remote_state.infrastructure.outputs.subnetDefaultAz2
  ]

  tags = {
    Name = "${var.ecsClusterName}ALB"
  }
}

resource "aws_alb_listener" "ecsALBListener" {
  load_balancer_arn = aws_alb.ecsAppLoadBalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecsBackendTargetGroup.arn
  }

  depends_on = [aws_alb_target_group.ecsBackendTargetGroup]
}
