output "vpc_id" {
  value = aws_vpc.eks-vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet2.id
}

output "sg_allow_web_traffic_id" {
  value = aws_security_group.allow-web-traffic.id
}
