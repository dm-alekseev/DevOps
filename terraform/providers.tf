provider "aws" {
  region = "eu-central-1" 
  shared_config_files      = ["/home/dalekseev/.aws/config"]
  shared_credentials_files = ["/home/dalekseev/.aws/credentials"]
  profile                  = "default"
}
terraform {
  required_version = "> 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}