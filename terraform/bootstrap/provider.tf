terraform {

  required_version = ">= 1.4.6"

  backend "s3" {
    bucket         = "terraform-spring-restapi"
    dynamodb_table = "terraform-spring-restapi-lock"
    key            = "state/base/terraform.tfstate"
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
