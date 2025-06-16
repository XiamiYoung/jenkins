provider "aws" {
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }
  }

  backend "s3" {
    bucket       = "young-cicd-poc-tfstate"
    key          = "state/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
  }
}