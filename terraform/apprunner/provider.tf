terraform {

  backend "s3" {
    bucket         = "terraform-spring-restapi"
    dynamodb_table = "terraform-spring-restapi-lock"
    key            = "state/apprunner/terraform.tfstate"
    region         = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

variable "container_configuration" {
  type = object({
    image_identifier         = string
    port                     = number
    auto_deployments_enabled = bool
  })
  default = {
    port : 8080,
    auto_deployments_enabled : true,
    image_identifier = "fredericci/spring-restapi:0.0.1-SNAPSHOT"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}