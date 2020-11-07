provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "state" {
  backend = "s3"
  config {
    bucket     = var.stateBucket
    region     = var.region
    key        = "terraform-state/${var.appName}/${var.environment}"
  }
}