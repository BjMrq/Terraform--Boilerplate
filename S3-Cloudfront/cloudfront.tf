resource "aws_cloudfront_origin_access_identity" "cloudfrontStaticAi" {
  comment = "ServerlessStatic For ${var.appName}"
}

resource "aws_cloudfront_distribution" "cloudfrontDistribution" {
  origin {
    domain_name = aws_s3_bucket.siteBucket.bucket_domain_name
    origin_id   = var.s3Origin

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfrontStaticAi.cloudfront_access_identity_path
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
    target_origin_id = var.s3Origin

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