
# VPC

resource "aws_vpc" "liberty-edr-lab-vpc-2" {
  provider = aws.useast2
  cidr_block       = "192.168.2.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "liberty-edr-lab-vpc-2"
    Project = "csd-edr-lab"
    Created-by = "terraform"
    Date-created = "28-09-2025"
  }
}


# Subnets

resource "aws_subnet" "liberty-edr-lab-subnet-public1-us-east-2a" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  cidr_block = "192.168.2.0/27"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {Name = "liberty-edr-lab-subnet-public1-us-east-2a"}
}

resource "aws_subnet" "liberty-edr-lab-subnet-public2-us-east-2b" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  cidr_block = "192.168.2.32/27"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {Name = "liberty-edr-lab-subnet-public2-us-east-2b"}
}

resource "aws_subnet" "liberty-edr-lab-subnet-private1-us-east-2a" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  cidr_block = "192.168.2.64/27"
  availability_zone = "us-east-2a"
  tags = {Name = "liberty-edr-lab-subnet-private1-us-east-2a"}
}

resource "aws_subnet" "liberty-edr-lab-subnet-private2-us-east-2b" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  cidr_block = "192.168.2.96/27"
  availability_zone = "us-east-2b"
  tags = {Name = "liberty-edr-lab-subnet-private2-us-east-2b"}
}

resource "aws_subnet" "liberty-edr-lab-subnet-private3-us-east-2a" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  cidr_block = "192.168.2.128/27"
  availability_zone = "us-east-2a"
  tags = {Name = "liberty-edr-lab-subnet-private3-us-east-2a"}
}

resource "aws_subnet" "liberty-edr-lab-subnet-private4-us-east-2b" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  cidr_block = "192.168.2.160/27"
  availability_zone = "us-east-2b"
  tags = {Name = "liberty-edr-lab-subnet-private4-us-east-2b"}
}

# Available CIDR for future use in the VPC: 192.168.2.192/27 and 192.168.2.224/27



# Route Tables

resource "aws_route_table" "liberty-edr-lab-rtb-public-2" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.liberty-edr-lab-igw-2.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-public1-us-east-2a" {
  provider = aws.useast2
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-public1-us-east-2a.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-public-2.id
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-public2-us-east-2b" {
  provider = aws.useast2
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-public2-us-east-2b.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-public-2.id
}


##

resource "aws_route_table" "liberty-edr-lab-rtb-private1-us-east-2a" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-2a.id
  }
  route {
    cidr_block     = "192.168.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.liberty-edr-lab-vpc-peer.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private1-us-east-2a" {
  provider = aws.useast2
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private1-us-east-2a.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private1-us-east-2a.id
}

##

resource "aws_route_table" "liberty-edr-lab-rtb-private2-us-east-2b" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-2a.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private2-us-east-2b" {
  provider = aws.useast2
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private2-us-east-2b.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private2-us-east-2b.id
}

##

resource "aws_route_table" "liberty-edr-lab-rtb-private3-us-east-2a" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-2a.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private3-us-east-2a" {
  provider = aws.useast2
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private3-us-east-2a.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private3-us-east-2a.id
}

##

resource "aws_route_table" "liberty-edr-lab-rtb-private4-us-east-2b" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.liberty-edr-lab-nat-public1-us-east-2a.id
  }
}

resource "aws_route_table_association" "rtb-association-liberty-edr-lab-subnet-private4-us-east-2b" {
  provider = aws.useast2
  subnet_id      = aws_subnet.liberty-edr-lab-subnet-private4-us-east-2b.id
  route_table_id = aws_route_table.liberty-edr-lab-rtb-private4-us-east-2b.id
}



# Internet Gateway

resource "aws_internet_gateway" "liberty-edr-lab-igw-2" {
  provider = aws.useast2
  vpc_id = aws_vpc.liberty-edr-lab-vpc-2.id
}


# NAT Gateway

resource "aws_eip" "liberty-edr-lab-eip-us-east-2a" {
  provider = aws.useast2
  domain   = "vpc"
  depends_on = [aws_internet_gateway.liberty-edr-lab-igw-2]
}

resource "aws_nat_gateway" "liberty-edr-lab-nat-public1-us-east-2a" {
  provider = aws.useast2
  allocation_id = aws_eip.liberty-edr-lab-eip-us-east-2a.id
  subnet_id     = aws_subnet.liberty-edr-lab-subnet-public1-us-east-2a.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.liberty-edr-lab-igw-2]
}




