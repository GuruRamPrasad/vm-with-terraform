output "ami" {
  value = data.aws_ami.amazon.image_id
}

output "arn" {
  value = data.aws_ami.amazon.arn
}

output "vpc" {
  value = data.aws_vpc.default_vpc.id
}

output "subnet" {
  value = data.aws_subnets.vpc_subnets.ids
}

output "subnet1" {
  value = data.aws_subnets.vpc_subnets.ids[0]
}

output "public_ip" {
  value = aws_instance.apache.public_ip
}

output "public_ip_1" {
  value = aws_instance.tomcat.public_ip
}