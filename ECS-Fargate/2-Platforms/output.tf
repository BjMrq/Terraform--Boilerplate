# ALB
output "publicDnsALB" {
  description = "The public dns to the load balancer"
  value = aws_alb.ecsAppLoadBalancer.dns_name
}

output "ALBServiceTargetGroupArn" {
  value = aws_alb_target_group.ecsServiceTargetGroup.arn
}

# RDS
output "dbHost" {
  description = "The host to connect to the database"
  value = aws_db_instance.RDS.address
}

output "dbPort" {
  description = "The port to connect to the database"
  value = aws_db_instance.RDS.port
}

output "dbName" {
  description = "The name of database"
  value = aws_db_instance.RDS.name
}

output "dbUser" {
  description = "The user to connect to the database"
  value = aws_db_instance.RDS.username
}

output "dbPassword" {
  description = "The password to connect to the database"
  sensitive = true
  value = aws_db_instance.RDS.password
}