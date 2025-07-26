terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }

        random = {
        source  = "hashicorp/random"
        version = "~> 3.0"
        }
    }
    
    required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "tf-backend" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI, replace with a valid one for your region
  instance_type = "t2.micro"

  tags = {
    Name = "tf-backend-instance"
  }
  
}