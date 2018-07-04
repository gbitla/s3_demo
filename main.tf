provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform_dl_s3_demo"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
