resource "aws_security_group" "nginx_server" {
    name = "nginx-server-sg"
    vpc_id = aws_vpc.my-vpc.id
    description = "Security group for Nginx server"
    #inbound rule to allow HTTP traffic
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  
}

#outbound rule to allow all traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # -1 means all protocols
        # This allows all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Tags for the security group
    tags = {
        Name = "nginx-server-sg"
    }
}