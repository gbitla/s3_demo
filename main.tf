provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "gb1-terraform-up-and-running-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

#reference - http://2ndwatch.com/blog/migratingterraformremoate/
terraform {
  backend "s3" {
    bucket  = "gb1-terraform-up-and-running-state"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.terraform_state.id}"
}

#data "terraform_remote_state" "foo" {
#  backend = "s3"
#
#  config {
#    bucket = "gb1-terraform-up-and-running-state"
#    key    = "terraform.tfstate"
#    region = "us-east-1"
#  }
#}

