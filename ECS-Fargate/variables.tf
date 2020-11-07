# General
variable "region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Tag the resources with an environment. Default is `staging`"
  type        = string
}

variable "appName" {
  description = "The name for the application"
  type        = string
}

# ECS 
variable "ecsClusterName" {
  default     = "spockee"
  description = "Cluster Name"
  type=string
}

# Task
variable "command" {
  default     = []
  description = "The command that is passed to the container"
  type        = list(string)
}

variable "cpu" {
  default     = 256
  description = "The number of cpu units reserved for the container"
  type        = number
}

variable "environment" {
  default     = []
  description = "The environment variables to pass to a container"
  type        = list(map(string))
}

variable "memory" {
  default     = 512
  description = "The hard limit (in MiB) of memory to present to the container"
  type        = number
}

variable "repositoryCredentials" {
  default     = {}
  description = "The private repository authentication credentials to use"
  type        = map(string)
}