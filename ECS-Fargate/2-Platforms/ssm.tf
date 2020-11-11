resource "aws_ssm_parameter" "RDSAddressParam" {
  name        = "/database/${var.appName}/endpoint"
  description = "Endpoint to connect to the ${var.appName} database"
  type        = "SecureString"
  value       = aws_db_instance.RDS.address

  tags = {
    Name         = "SSM"
    Application  = var.appName
    Environement = var.env
  }
}

resource "aws_ssm_parameter" "RDSUserParam" {
  name        = "/database/${var.appName}/user"
  description = "Endpoint to connect to the ${var.appName} database"
  type        = "SecureString"
  value       = aws_db_instance.RDS.username

  tags = {
    Name         = "SSM"
    Application  = var.appName
    Environement = var.env
  }
}

resource "aws_ssm_parameter" "RDSPasswordParam" {
  name        = "/database/${var.appName}/password"
  description = "Endpoint to connect to the ${var.appName} database"
  type        = "SecureString"
  value       = aws_db_instance.RDS.password

  tags = {
    Name         = "SSM"
    Application  = var.appName
    Environement = var.env
  }
}