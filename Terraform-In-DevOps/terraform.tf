terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }

  backend "s3" {
    bucket = "terra-state-bucket-devops"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terra-state-table"
  }
}