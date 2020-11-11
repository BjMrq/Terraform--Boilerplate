resource "aws_secretsmanager_secret" "dockerRegistryAuth" {
  name = "fhhjgsdsdj"
}

resource "aws_secretsmanager_secret_version" "dockerRegistryAuthSecret" {
  secret_id     = aws_secretsmanager_secret.dockerRegistryAuth.id
  secret_string = jsonencode(var.dockerRegistryAuth)
}