terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    
    required_version = ">= 1.0"
}

provider "aws" {
    region = "ap-south-1"
}

data "aws_ami" "name" {
  most_recent = true
    owners      = ["amazon"]
}

output "name" {
  value = data.aws_ami.name.id
  
}

resource "aws_instance" "my-server" {
  ami = "ami-0f535a71b34f2d44a" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  tags = {
    Name = "MyFirstServer"
  }
}