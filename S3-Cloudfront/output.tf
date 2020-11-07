output "s3_bucket_id" {
  description = "The ID of the S3 Bucket hosting the application"
  value       = aws_s3_bucket.siteBucket.id
}

output "cloudfront_id" {
  description = "The ID of the CloudFront distribution fronting the application"
  value       = aws_cloudfront_distribution.cloudfrontDistribution.id
}

output "domain_name" {
    description = "The CloudFront domain name"
    value       = aws_cloudfront_distribution.cloudfrontDistribution.domain_name
}