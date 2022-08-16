provider "aws" {
  profile = "default"
  region  = "us-west-1"
  
  default_tags {
    tags = {
      environment = local.environment
      region      = var.aws_region
      service     = local.service_name
    }
  }
}

terraform {
  required_version = "= 1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }
  backend "s3" {
    bucket = "tf-marklin"
    key    = "state"
    region = "us-west-2"
  }
}