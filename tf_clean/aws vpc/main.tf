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
resource "aws_vpc" "my-vpc" {
    cidr_block = "192.168.0.0/24"
    tags = {
      name = "my-vpc"
    }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.my-vpc.id
    cidr_block        = "192.168.0.0/25"
    availability_zone = "ap-south-1a"   
    tags = {
        Name = "private-subnet"
    }
}
 
# Public Subnet
resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.my-vpc.id
    cidr_block        = "192.168.0.128/25"
    availability_zone = "ap-south-1a"   
    tags = {
        Name = "public-subnet"
    }
    map_public_ip_on_launch = true
}

# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-internet-gateway"
    }
}

# Routing Table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "public-route-table"
    }
    route  {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id

    }
}

# Associate Public Subnet with Route Table
resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}


#Instances of our VPC
resource "aws_instance" "web_server" {
    ami           = "ami-0f918f7e67a3323f0" # Example AMI, replace with a valid one for your region
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.public_subnet.id
    tags = {
        Name = "web-server"
    }
    availability_zone = "ap-south-1a"
}

resource "aws_instance" "db_server" {
    ami           = "ami-0a1235697f4afa8a4" # Example AMI, replace with a valid one for your region
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.private_subnet.id
    tags = {
        Name = "db-server"
    }
    availability_zone = "ap-south-1a"
    
    
}

    