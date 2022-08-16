######## default tags ########
locals {
  resource_prefix = aws_ecs_cluster.ecs_cluster.name
}

variable "environment" {
  type        = string
  default     = "staging"
  description = "Environment to deploy infrastructure to."
}

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "Region to deploy infrastructure to."
}

variable "availability_zone" {
  type        = string
  default     = "us-west-2a"
  description = "Availability zone to deploy infrastructure to."
}


######## ECS Cluster ########
variable "cluster_name" {
  type        = string
  description = "Name of ECS cluster"
  default     = "ecs-cluster"
}

variable "container_name" {
  type        = string
  description = "Name of container in task definition"
  default     = "enzyme-results"
}

variable "container_port" {
  type        = string
  description = "Container port"
  default     = "80"
}

variable "image_url" {
  type        = string
  description = "URL of image to use in ECS"
  default     = "registry-1.docker.io/markgllin/python-flask-helloworld"
}

variable "desired_ecs_svc_count" {
  type        = number
  description = "Desired # of ECS services to spin up in ECS cluster"
  default     = 2
}