
# VPC

resource "aws_vpc" "liberty-edr-lab-vpc" {
  cidr_block       = "192.168.1.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "liberty-edr-lab-vpc"
    Project = "csd-edr-lab"
    Created-by = "terraform"
    Date-created = "28-09-2025"
  }
}


# Subnets

resource "aws_subnet" "liberty-edr-lab-subnet-public1-us-east-1a" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  cidr_block = "192.168.1.0/27"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "liberty-edr-lab-subnet-public2-us-east-1b" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  cidr_block = "192.168.1.32/27"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "liberty-edr-lab-subnet-private1-us-east-1a" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  cidr_block = "192.168.1.64/27"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "liberty-edr-lab-subnet-private2-us-east-1b" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  cidr_block = "192.168.1.96/27"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "liberty-edr-lab-subnet-private3-us-east-1a" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  cidr_block = "192.168.1.128/27"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "liberty-edr-lab-subnet-private4-us-east-1b" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  cidr_block = "192.168.1.160/27"
  availability_zone = "us-east-1b"
}

# Available CIDR for future use in the VPC: 192.168.1.192/27 and 192.168.1.224/27



# Route Tables

resource "aws_route_table" "liberty-edr-lab-rtb-public" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.liberty-edr-lab-igw.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-public1-us-east-1a" {
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-public1-us-east-1a.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-public.id
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-public2-us-east-1b" {
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-public2-us-east-1b.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-public.id
}


##

resource "aws_route_table" "liberty-edr-lab-rtb-private1-us-east-1a" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-1a.id
  }
  route {
    cidr_block     = "192.168.2.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.liberty-edr-lab-vpc-peer.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private1-us-east-1a" {
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private1-us-east-1a.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private1-us-east-1a.id
}

##

resource "aws_route_table" "liberty-edr-lab-rtb-private2-us-east-1b" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-1a.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private2-us-east-1b" {
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private2-us-east-1b.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private2-us-east-1b.id
}

##

resource "aws_route_table" "liberty-edr-lab-rtb-private3-us-east-1a" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-1a.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private3-us-east-1a" {
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private3-us-east-1a.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private3-us-east-1a.id
}

##

resource "aws_route_table" "liberty-edr-lab-rtb-private4-us-east-1b" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-1a.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private4-us-east-1b" {
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private4-us-east-1b.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private4-us-east-1b.id
}


# Internet Gateway

resource "aws_internet_gateway" "liberty-edr-lab-igw" {
  vpc_id = aws_vpc.liberty-edr-lab-vpc.id
}


# NAT Gateway

resource "aws_eip" "liberty-edr-lab-eip-us-east-1a" {
  domain   = "vpc"
  depends_on = [aws_internet_gateway.liberty-edr-lab-igw]
}

resource "aws_nat_gateway" "liberty-edr-lab-nat-public1-us-east-1a" {
  allocation_id = aws_eip.liberty-edr-lab-eip-us-east-1a.id
  subnet_id     = aws_subnet.liberty-edr-lab-subnet-public1-us-east-1a.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.liberty-edr-lab-igw]
}




