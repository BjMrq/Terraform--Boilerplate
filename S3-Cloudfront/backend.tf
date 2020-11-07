provider "aws" {
  region = var.region
}

# terraform init -backend-config="init.config" 
terraform {
  backend "s3" {}
}