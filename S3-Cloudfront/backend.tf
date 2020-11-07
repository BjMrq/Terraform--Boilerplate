provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket= "ecs-terraform-remote-state-bjmrq"
    region="ca-central-1"
    key= "teraform-state"
  }
}