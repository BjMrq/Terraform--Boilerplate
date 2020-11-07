provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket     = "YOUR_BUCKET_STATE"
    region     = "YOUR_REGION"
    key        = "THE_KEY_PATH"
  }
}