resource "aws_alb_target_group" "ecsBackendTargetGroup" {
  name        = "${var.serviceName}TagetGroup"
  port        = var.dockerContainerPort
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.VPCdefaultId
  target_type = "ip"

  stickiness {    
    type            = "lb_cookie" 
    cookie_duration = 1800
    enabled         = true
  }  

  health_check {
    path                = "/api/v1/check/health"
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
    data.terraform_remote_state.infrastructure.outputs.defaultAz1Id,
    data.terraform_remote_state.infrastructure.outputs.defaultAz2Id
  ]

  tags = {
    Name = "${var.ecsClusterName}ALB"
  }
}

resource "aws_alb_listener" "ecsALBListenerHTTP" {
  load_balancer_arn = aws_alb.ecsAppLoadBalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecsBackendTargetGroup.arn
  }

  depends_on = [aws_alb_target_group.ecsBackendTargetGroup]
}

# For HTTPS listener
# resource "aws_alb_listener" "ecsALBListenerHTTPS" {
#   load_balancer_arn = aws_alb.ecsAppLoadBalancer.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   =aws_acm_certificate_validation.elb_cert.certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.ecsBackendTargetGroup.arn
#   }

#   depends_on = [aws_alb_target_group.ecsBackendTargetGroup]
# }