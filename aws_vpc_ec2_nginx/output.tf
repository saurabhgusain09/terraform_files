output "instance_public_ip" {
    value = aws_instance.nginx_server.public_ip
    description = "value of the public IP address of the Nginx server instance"
}

output "url" {
    value = "http://${aws_instance.nginx_server.public_ip}"
    description = "value of the URL to access the Nginx server"
  
}