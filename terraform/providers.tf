
terraform {



  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

  }

  required_version = "~> 1.7.0"


  backend "s3" {
    bucket = "daniel-intercax"
    key    = "ic-challenge/terraform.tfstate"
    region = "us-east-2"
    encrypt = true
  }  
}

# provider "aws" {
#   region  = "us-east-2"
#   profile = "github"
# }
