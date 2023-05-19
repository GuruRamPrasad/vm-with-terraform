 resource "aws_security_group" "guru" { 
  name        = "guru"
  description = "web inbound traffic"
  /*vpc_id      = data.aws_vpc.default_vpc.id*/

  ingress {
    description      = "guru from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
ingress {
    description      = "guru from VPC"
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
    Name = "guru"
  }
}



resource "aws_instance" "apache"{
    ami = data.aws_ami.amazon.image_id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.guru.id]
    subnet_id = data.aws_subnets.vpc_subnets.ids[0]
    key_name = aws_key_pair.deployer.id

    /*user_data = << EOF
		#! /bin/bash
          sudo yum update -y
		sudo yum install -y httpd
		sudo systemctl start httpd
		sudo systemctl enable httpd
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
	EOF*/

  user_data = file("scripts/apache.sh")
  
    tags = {
        Name = "apache"
        teams = "devops"
        automation = "true"
    }
    depends_on = [ "aws_security_group.guru","aws_key_pair.deployer"]
    lifecycle {
      create_before_destroy = true
    }
}