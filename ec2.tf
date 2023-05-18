resource "aws_security_group" "web_sg" {
  Name        = "web_sg"
  description = "web inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web_sg"
  }
}



resource "aws_instance" "web"{
    ami = 
    instance_type = 
    security_groups = [aws_security_group.web_sg.id]
    subnet_id = 
    tags = {
        name = "web"
        teams = "devops"
        automation = "true"
    }
}
