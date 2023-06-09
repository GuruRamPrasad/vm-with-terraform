resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat_sg"
  description = "web inbound traffic"
  /*vpc_id      = data.aws_vpc.default_vpc.id*/

  ingress {
    description = "guru from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "guru from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tomcat_sg"
  }
}



resource "aws_instance" "tomcat" {
  ami                    = data.aws_ami.amazon.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.tomcat_sg.id]
  subnet_id              = data.aws_subnets.vpc_subnets.ids[0]
  key_name               = aws_key_pair.deployer.id

  tags = {
    Name       = "tomcat"
    teams      = "devops"
    automation = "true"
  }
  depends_on = ["aws_security_group.tomcat_sg", "aws_key_pair.deployer"]
  lifecycle {
    create_before_destroy = true
  }
}