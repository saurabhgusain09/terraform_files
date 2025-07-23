terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}

provider "aws" {
  region = var.region
}
resource "aws_instance" "my-server" {
  ami = "ami-0f535a71b34f2d44a" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  tags = {
    Name = "MyFirstServer"
  }
}