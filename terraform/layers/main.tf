terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket          = "rapyd-sentinel-tf-20250714123158673000000001"
    key             = "terraform.tfstate"
    region          = "us-east-1"
    encrypt         = true
    use_lockfile    = true
  }
}