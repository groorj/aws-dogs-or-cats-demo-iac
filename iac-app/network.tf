# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Dogs or Cats App"
    Application = "dogs-or-cats.com"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id        = aws_vpc.vpc.id

  tags = {
    Name = "Dogs Or Cats IGW"
    Application = "dogs-or-cats.com"
  }
}

# Create (one) NAT Gateway
resource "aws_eip" "eip-nat-gateway" {
  # count = 1
  vpc = true
}
resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.eip-nat-gateway.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "Dogs Or Cats NAT Gateway 1"
    Application = "dogs-or-cats.com"
  }
}

# Create subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1a"

  tags = {
    Name = "Public Subnet 1"
    Application = "dogs-or-cats.com"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1b"

  tags = {
    Name = "Public Subnet 2"
    Application = "dogs-or-cats.com"
  }
}
resource "aws_subnet" "public-subnet-3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1d"

  tags = {
    Name = "Public Subnet 3"
    Application = "dogs-or-cats.com"
  }
}
resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.10.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ca-central-1a"

  tags = {
    Name = "Private Subnet 1"
    Application = "dogs-or-cats.com"
  }
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.11.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ca-central-1b"

  tags = {
    Name = "Private Subnet 2"
    Application = "dogs-or-cats.com"
  }
}
resource "aws_subnet" "private-subnet-3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.2.12.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ca-central-1d"

  tags = {
    Name = "Private Subnet 3"
    Application = "dogs-or-cats.com"
  }
}

# Create the Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
    Application = "dogs-or-cats.com"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway-1.id
  }

  tags = {
    Name = "Private Route Table"
    Application = "dogs-or-cats.com"
  }
}

# Create Route Table Associations
resource "aws_route_table_association" "public-subnet-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public-subnet-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public-subnet-association-3" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-association-3" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private.id
}

# End;