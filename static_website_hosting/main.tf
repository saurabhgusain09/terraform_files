terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
    required_version = ">= 0.12"
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "myweb_portfolio" {
  bucket = "mywebapp-portfolio"

  }

resource "aws_s3_bucket_public_access_block" "permissions_block" {
  bucket = aws_s3_bucket.myweb_portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  
}


resource "aws_s3_bucket_policy" "myweb-app_policy" {
  bucket = aws_s3_bucket.myweb_portfolio.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.myweb_portfolio.arn}/*"
      }
    ]
  })
  
}


resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.myweb_portfolio.id

  index_document {
    suffix = "index.html"
  }

  
  
}

  
resource "aws_s3_bucket_object" "frontpage" {
    bucket = aws_s3_bucket.myweb_portfolio.bucket
    key    = "index.html"
    source="./index.html"
    content_type = "text/html"
    
}
resource "aws_s3_bucket_object" "stylepage" {
    bucket = aws_s3_bucket.myweb_portfolio.bucket
    key    = "style.css"
    source="./style.css"
    content_type = "text/css"
    
}

resource "aws_s3_bucket_object" "scriptpage" {
    bucket = aws_s3_bucket.myweb_portfolio.bucket
    key    = "script.js"
    source="./script.js"
    content_type = "application/javascript"
    
}


output "name" {
  value =aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "The endpoint of the static website"
}