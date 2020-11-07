
# S3

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
      identifiers = [aws_cloudfront_origin_access_identity.cloudfrontAccessIdentity.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.siteBucket.arn]
    effect    = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cloudfrontAccessIdentity.iam_arn]
    }
  }
}