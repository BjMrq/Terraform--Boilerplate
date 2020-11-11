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

# RDS
variable "dbUser" {
  description = "The user to connect to the databasen"
  type        = string
}

variable "dbPassword" {
  description = "The password to connect to the database"
  type        = string
}

variable "rdsCidrAccess" {
  description = "Cidr to access RDS from outside"
  type        = string
}

# ECS 
variable "ecsClusterName" {
  description = "Cluster Name"
  type        = string
}

variable "serviceName" {
  description = "Name of service that will run the task"
  type = string
}

variable "dockerContainerPort" {
  description = "Port to map in the container"
  type        = number
}