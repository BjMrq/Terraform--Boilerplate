
resource "aws_s3_bucket" "siteBucket" {
  bucket = "${var.appName}-${var.environment}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name        = var.appName
    Environment = var.environment
  }
}
