# ARN 
output "dockerAuthArn"{
  description="Arn of the secret holding Docker credentials"
  value = aws_secretsmanager_secret_version.dockerRegistryAuthSecret.arn
}

output "fargateRoleArn" {
  description="Arn of ecs fargate role"
  value = aws_iam_role.fargateRole.arn
}

# Subnets
output "defaultVPCId" {
  description="Default VPC id"
  value = aws_default_vpc.default.id
}

output "defaultAz1Id" {
  description="Default availibility zone 1 subnet id"
  value = aws_default_subnet.defaultAz1.id
}

output "defaultAz1Cidr" {
  description="Default availibility zone 1 subnet cidr"
  value = aws_default_subnet.defaultAz1.cidr_block
}

output "defaultAz2Id" {
  description="Default availibility zone 2 subnet id"
  value = aws_default_subnet.defaultAz2.id
}

output "defaultAz2Cidr" {
  description="Default availibility zone 2 subnet cidr"
  value = aws_default_subnet.defaultAz2.cidr_block
}

output "RDSSubnetName" {
  description="RDS subnet name"
  value = aws_db_subnet_group.RDSSubnet.name
}

# VPC 
output "VPCdefaultCidr" {
  description="Default VPC Cidr block"
  value = aws_default_vpc.default.cidr_block
}

output "VPCdefaultId" {
  description="Default VPC id"
  value = aws_default_vpc.default.id
}