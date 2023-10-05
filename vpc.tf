resource "aws_vpc" "vpc-atrato" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-atrato"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "atrato-igw" {
  vpc_id = aws_vpc.vpc-atrato.id
  tags = {
    Name = "atrato-igw"
  }
}

#Public
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc-atrato.id
  cidr_block        = var.subred_publica
  availability_zone = var.availability_zone
  tags = {
    Name = "atrato-public"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-atrato.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.atrato-igw.id
  }
  tags = {
    Name = "atrato-public-rt"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

#Private
resource "aws_subnet" "private_subnet_ec2" {
  vpc_id            = aws_vpc.vpc-atrato.id
  cidr_block        = var.subred_priv_ec2
  availability_zone = var.availability_zone
  tags = {
    Name = "atrato-priv-ec2"
  }
}

#Private subnet for RDS
resource "aws_subnet" "private_subnet_rds" {
  vpc_id            = aws_vpc.vpc-atrato.id
  cidr_block        = var.subred_priv_rds
  availability_zone = var.availability_zone
  tags = {
    Name = "atrato-priv-rds"
  }
}

#Elastic IP for NAT gw
resource "aws_eip" "Eip_priv" {
  domain = "vpc"
  tags = {
    Name = "EIP_PRIV"
  }
}

resource "aws_nat_gateway" "priv_nat_gateway" {
  subnet_id     = aws_subnet.private_subnet_rds.id
  allocation_id = aws_eip.Eip_priv.id

  tags = {
    Name = "atrato-nat-gw"
  }
}

resource "aws_route_table" "priv_route_table" {
  vpc_id = aws_vpc.vpc-atrato.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.priv_nat_gateway.id
  }

  tags = {
    Name = "priv-rt-nat"
  }
}

resource "aws_route_table_association" "private_routetable_association_rds" {
  subnet_id      = aws_subnet.private_subnet_rds.id
  route_table_id = aws_route_table.priv_route_table.id
}
