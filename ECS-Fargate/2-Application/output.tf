output "publicDnsALB" {
  value = aws_alb.ecsAppLoadBalancer.dns_name
}