
resource "aws_s3_bucket" "siteBucket" {
  bucket = "${var.appName}-${var.environment}"
  acl    = "public-read"
  
  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = var.appName
    Environment = var.environment
  }
}
