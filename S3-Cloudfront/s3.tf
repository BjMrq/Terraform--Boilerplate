
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

resource "aws_s3_bucket_policy" "siteBucketPolicy" {
  bucket = aws_s3_bucket.siteBucket.id

  policy = data.aws_iam_policy_document.s3Policy.json
}

data "aws_iam_policy_document" "s3Policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.siteBucket.arn}/*"]
    effect    = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cloudfrontStaticAi.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.siteBucket.arn]
    effect    = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cloudfrontStaticAi.iam_arn]
    }
  }
}