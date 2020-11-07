provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket     = "terraform-remote-state-bjmrq"
    region     = "ca-central-1"
    key        = "spockee-backend-end/dev/infrastructure.tfstate"
  }
}


# registry.gitlab.com/spockee/backend