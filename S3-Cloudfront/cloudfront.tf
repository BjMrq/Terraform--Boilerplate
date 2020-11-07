resource "aws_cloudfront_origin_access_identity" "cloudfrontAccessIdentity" {
  comment = "Origin Access Identity for S3"
}

resource "aws_cloudfront_distribution" "cloudfrontDistribution" {
  origin {
    domain_name = aws_s3_bucket.siteBucket.bucket_domain_name
    origin_id   = aws_s3_bucket.siteBucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfrontAccessIdentity.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  price_class         = var.priceClass
  default_root_object = "index.html"

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.siteBucket.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = var.minTttl
    default_ttl            = var.defaultTtl
    max_ttl                = var.maxTtl
  }

  tags = {
    Name        = var.appName
    Environment = var.environment
  }
}