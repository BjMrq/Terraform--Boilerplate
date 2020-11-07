# General
variable "region" {
  default     = "ca-central-1"
  description = "AWS Region"
  type        = string
}

variable "environment" {
  default     = "staging"
  description = "Tag the resources with an environment. Default is `staging`"
  type        = string
}

variable "appName" {
  default="frontend-app"
  description = "The name for the application"
  type        = string
}


# Cloudfront

variable "s3Origin" {
  default="myS3Origin"
  description = "S3 Origin"
  type        = string
}

variable "minTttl" {
  default     = 0
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  type        = number
}

variable "defaultTtl" {
  default     = 3600
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request"
  type        = number
}

variable "maxTtl" {
  default     = 86400
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated."
  type        = number
}

variable "errorCachingMinTttl" {
  default     = 60
  description = "he minimum amount of time you want HTTP error codes to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  type        = number
}

variable "priceClass" {
  default="PriceClass_100"
  type=string
}
