provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "sctp-ce10-tfstate"
    key    = "sctp-ce10-tfstate" # Change this if needed
    region = "ap-southeast-1"
  }
}

resource "aws_s3_bucket" "s3_tf" {
  bucket_prefix = "sankari"
}

resource "aws_s3_bucket_versioning" "s3_tf_versioning" {
  bucket = aws_s3_bucket.s3_tf.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "logging_bucket" {
  bucket = "s3-logging-bucket-example"
}

resource "aws_s3_bucket_logging" "log" {
  bucket = aws_s3_bucket.s3_tf.id

  target_bucket = aws_s3_bucket.logging_bucket.id
  target_prefix = "log/"
}

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
