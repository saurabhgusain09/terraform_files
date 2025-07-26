resource "aws_vpc" "my-vpc" {
    cidr_block = "192.168.0.0/24"
    tags = {
      name = "my-vpc"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.my-vpc.id
    cidr_block        = "192.168.0.0/25"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "private-subnet"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.my-vpc.id
    cidr_block        = "192.168.0.128/25"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "public-subnet"
    }
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-internet-gateway"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "public-route-table"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}
