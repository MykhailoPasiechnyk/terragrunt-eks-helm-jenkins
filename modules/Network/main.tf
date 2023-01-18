#------------------------------------------------------
#----------------VPC module for Cluster----------------
#------------------------------------------------------


#-------------------VPC------------------------

resource "aws_vpc" "eks-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "jenkins"
  }
}


#--------------------IG------------------------

resource "aws_internet_gateway" "vpc-ig" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "vpc-ig"
  }
}


#--------------------Route Table----------------

resource "aws_route_table" "eks-route_table" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.vpc-ig.id
  }

  tags = {
    Name = "eks-rt"
  }
}


#-------------------Public Subnets------------------

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = var.public_subnet1_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.public_subnet2_cidr
  availability_zone       = var.public_subnet2_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}


#-------------------Route Table Association-------------

resource "aws_route_table_association" "pub_sub_1_to_rta" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.eks-route_table.id
}

resource "aws_route_table_association" "pub_sub_2_to_rta" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.eks-route_table.id
}


#-------------------Security Group for EKS----------------

resource "aws_security_group" "allow-web-traffic" {
  name        = "allow_tls"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.eks-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
    Name = "allow-web"
  }
}
