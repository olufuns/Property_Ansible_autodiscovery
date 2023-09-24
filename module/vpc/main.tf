# Create a custom VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.tag-vpc
  }
}
#  Create Public subnet 01
resource "aws_subnet" "pub-sn-01" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.cidr-pub-01
  tags = {
    Name = var.tag-pub-subnet1
  }
}
#  Create Public subnet 02
resource "aws_subnet" "PUB-SN-02" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = var.cidr-pub-02
  tags = {
    Name = var.tag-pub-subnet2
  }
}

#  Create Private subnet 01
resource "aws_subnet" "PRT-SN-01" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = var.cidr-prt-1
  tags = {
    Name = var.tag-prt-subnet1
  }
}
#  Create Private subnet 02
resource "aws_subnet" "PRT-SN-02" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = var.cidr-prt-2
  tags = {
    Name = var.tag-prt-subnet2
  }
}
# Creating keypair
resource "aws_key_pair" "keypair" {
  key_name   = var.keypair-name
  public_key = file(var.path-to-pub-key)
}

# Creating internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.tag-igw
  }
}
# Creating Elastic IP for Natgateway
resource "aws_eip" "eip" {
  domain = "vpc"
}
# Create Natgateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-sn-01.id
  tags = {
    Name = var.tag-nat
  }
}
# Creating public route table
resource "aws_route_table" "PUB-RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr-pub-RT
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.tag-pub-rt
  }
}
# Creating private route table
resource "aws_route_table" "PRT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = var.cidr-pub-RT
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = var.tag-prt-rt
  }
}
# Attaching public subnet 01 to public route table
resource "aws_route_table_association" "PUB-RT1-associated" {
  subnet_id      = aws_subnet.pub-sn-01.id
  route_table_id = aws_route_table.PUB-RT.id
}
# Attaching public subnet 02 to public route table
resource "aws_route_table_association" "PUB-RT2-associated" {
  subnet_id      = aws_subnet.PUB-SN-02.id
  route_table_id = aws_route_table.PUB-RT.id
}
# Associate private subnet 01 to my private route table
resource "aws_route_table_association" "PRT1-associated" {
  subnet_id      = aws_subnet.PRT-SN-01.id
  route_table_id = aws_route_table.PRT.id
}
# Associating private subnet 02 to my private route table
resource "aws_route_table_association" "PRT2-associated" {
  subnet_id      = aws_subnet.PRT-SN-02.id
  route_table_id = aws_route_table.PRT.id
}

