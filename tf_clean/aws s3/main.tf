terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }

        random={
        source  = "hashicorp/random"
        version = "~> 3.0"
        }
    }
    
    required_version = ">= 0.12"
}
provider "aws" {
    region = var.region
}

resource "random_id" "rand_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "first_terrabucket7239" {
    bucket = "bucker-${random_id.rand_id.hex}"
        }

resource "aws_s3_bucket_object" "bucket_data" {
    bucket = aws_s3_bucket.first_terrabucket7239.bucket
    source = "./file1.txt"
    key = "my_data.txt"
    

  
}        