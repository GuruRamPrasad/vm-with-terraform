resource "aws_s3_bucket" "tfstate" {
  bucket = "my-tfstatet-bucket"

  tags = {
    Name        = "my-tfstatet-bucket"
    Environment = "Dev"
  }
}