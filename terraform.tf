terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-cicd-8099"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    # use_lockfile   = true  # Enables locking using the default method
    # dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

