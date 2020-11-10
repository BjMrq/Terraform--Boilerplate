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

variable "stateBucket" {
  description = "The bucket use to store state"
  type        = string
}

variable "appName" {
  description = "The name for the application"
  type        = string
}

# ECS 
variable "ecsClusterName" {
  description = "Cluster Name"
  type        = string
}

# Task

variable "taskDefinitionName" {
  description = "The name of a container"
  type        = string
}

variable "dockerImage" {
  description = "The image used to start a container"
  type        = string
}

variable "dockerContainerPort" {
  description = "Port to map in the container"
  type        = number
}

variable "command" {
  default     = []
  description = "The command that is passed to the container"
  type        = list(string)
}

variable "cpu" {
  description = "The number of cpu units reserved for the container"
  type        = number
}

variable "environmentVariables" {
  default     = []
  description = "The environment variables to pass to a container"
  type        = list(map(string))
}

variable "memory" {
  description = "The hard limit (in MiB) of memory to present to the container"
  type        = number
}

# Service

variable "serviceName" {
  description = "Name of service that will run the task"
  type = string
}

variable "taskNumber" {
  default     = 1
  description = "Desired number of task running in the ECS service"
  type        = number
}
