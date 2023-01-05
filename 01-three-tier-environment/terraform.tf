terraform {
  required_version = "> 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21.0"
    }
  }


  backend "s3" {
    bucket         = "example-remote-state"
    encrypt        = true
    key            = "example/example.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "example-remote-lock-table"
  }
}

provider "aws" {
  region = "eu-central-1"
}