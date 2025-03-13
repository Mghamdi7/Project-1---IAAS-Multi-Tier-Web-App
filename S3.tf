resource "aws_s3_bucket" "SS3" {
    bucket = "mghamdi9090900000"
   
    tags = {
    Name        = "My bucket"
  }
}

terraform {
backend "s3" {

    bucket  =   "mghamdi9090900000"
    key     =   "Home/lock file/terraform.tfstate"
    region  =   "us-east-1"
    profile =   "default" 
    
}
}

resource "aws_dynamodb_table" "DB" {
  name             = "DBlock"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws" {
  region  = "us-east-1"
  alias = "default" 
  }

  output "S3ID" {
    value = aws_s3_bucket.SS3.id
  }

 resource "time_sleep" "sleep" {
   create_duration = "30s"
 }