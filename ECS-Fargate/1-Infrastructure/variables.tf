# General
variable "region" {
  description = "AWS Region"
  type        = string
}

variable "availabilityZone1" {
  description = "AWS Availibility Zone 1"
  type        = string
}

variable "availabilityZone2" {
  description = "AWS Availibility Zone 2"
  type        = string
}

variable "env" {
  description = "Tag the resources with an environment. Default is `staging`"
  type        = string
}

variable "appName" {
  description = "The name for the application"
  type        = string
}


# Secret
variable "dockerRegistryAuth" {
  default     = {}
  description = "The private repository authentication credentials to use (username, password)"
  type        = map(string)
}