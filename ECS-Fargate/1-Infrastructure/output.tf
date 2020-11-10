output "dockerAuthArn"{
  value = aws_secretsmanager_secret_version.dockerRegistryAuthSecret.arn
}

output "fargateRoleArn" {
  value = aws_iam_role.fargateRole.arn
}

output "defaultAz1Id" {
  value = aws_default_subnet.defaultAz1.id
}

output "defaultAz2Id" {
  value = aws_default_subnet.defaultAz2.id
}


output "VPCdefaultCidr" {
  value = aws_default_vpc.default.cidr_block
}

output "VPCdefaultId" {
  value = aws_default_vpc.default.id
}