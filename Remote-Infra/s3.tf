resource "aws_s3_bucket" "remote_s3" {
  bucket = "terra-state-bucket-devops"

  tags = {
    Name        = "terra-state-bucket-devops"
  }
}