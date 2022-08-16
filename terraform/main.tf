provider "aws" {
  profile = "default"
  region  = "us-west-1"

  default_tags {
    tags = {
      environment = var.environment
      region      = var.aws_region
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