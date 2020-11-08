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

# If you already have a backend set up use the following

# data "terraform_remote_state" "state" {
#   backend = "s3"

#   config = {
#     bucket = var.stateBucketName
#     region = var.region
#     key    = "terraform-state/${appName}/${environment}"
#   }
# }