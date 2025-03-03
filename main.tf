terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  backend "s3" {
    bucket = "pr-tstate"
    key    = "state/state1"
    region = "us-east-1"

  }
}
