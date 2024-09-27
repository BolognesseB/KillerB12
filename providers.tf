terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }


  backend "s3" {
    bucket         = "terraform-project-x"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}


provider "aws" {
  region = "us-east-1"
  # Configuration options
}