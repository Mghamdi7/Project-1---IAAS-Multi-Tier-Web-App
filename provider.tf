provider "aws" {
  region  = "us-east-1"
  profile = "default" 
  }

  provider "github" {
token = var.access_token
  } 