# General
variable "region" {
  description = "AWS Region"
  type        = string
}

variable "env" {
  description = "Tag the resources with an environment. Default is `staging`"
  type        = string
}

variable "stateBucket" {
  description = "The bucket use to store state"
  type        = string
}

variable "appName" {
  description = "The name for the application"
  type        = string
}

# VPC Sbnets

variable "availabilityZone1" {
  description = "AWS Availibility Zone 1"
  type        = string
}

variable "availabilityZone2" {
  description = "AWS Availibility Zone 2"
  type        = string
}

# RDS
variable "dbUser" {
  description = "The user to connect to the databasen"
  type        = string
}

variable "dbPassword" {
  description = "The password to connect to the database"
  type        = string
}
