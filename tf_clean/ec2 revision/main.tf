terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region = var.region
}
resource "aws_instance" "my-server" {   
    ami           = "ami-0f918f7e67a3323f0" # Example AMI ID, replace with a valid one
    instance_type = "t2.micro"
    tags = {
        Name = "MyServer"
}
}