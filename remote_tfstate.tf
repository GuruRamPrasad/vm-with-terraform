terraform {
  backend "s3" {
    bucket = "my-tfstatet-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "remote_tfstate_lock"
  }
}


resource "aws_dynamodb_table" "remote_tfstate_lock" {
  name           = "remote_tfstate_lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }

}