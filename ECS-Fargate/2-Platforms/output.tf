output "publicDnsALB" {
  description = "The public dns to the load balancer"
  value = aws_alb.ecsAppLoadBalancer.dns_name
}

output "dbUser" {
  description = "The user to connect to the databasen"
  value = aws_db_instance.RDS.user
}

output "dbPassword" {
  description = "The password to connect to the database"
  sensitive = true
  value = aws_db_instance.RDS.password
}