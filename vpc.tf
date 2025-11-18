resource "aws_vpc" "dev_proj_1_vpc_ap_south_1" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
    Environment = "Dev"
  }
}

# Creating the subnet in VPC - public subnet-1
resource "aws_subnet" "dev_proj_1_public_subnets_1" {
  vpc_id            = aws_vpc.dev_proj_1_vpc_ap_south_1.id
  cidr_block        = var.cidr_public_subnet[0]
  availability_zone = var.availability_zone[0] # ap-south-1a
  tags = {
    Name = "dev-proj-public-subnet-1"
  }
}

#public-subnet-2
resource "aws_subnet" "dev_proj_1_public_subnets_2" {
  vpc_id            = aws_vpc.dev_proj_1_vpc_ap_south_1.id
  cidr_block        = var.cidr_public_subnet[1]
  availability_zone = var.availability_zone[1] # ap-south-1a
  tags = {
    Name = "dev-proj-public-subnet-2"
  }
}

#setup of private subnet using count variables
resource "aws_subnet" "dev_proj_1_private_subnets"{

  vpc_id            = aws_vpc.dev_proj_1_vpc_ap_south_1.id
  count             = length(var.cidr_private_subnet) # total count = 2
  cidr_block        = element(var.cidr_private_subnet, count.index) # index = 0, index = 1
  availability_zone = var.availability_zone[1] # ap-south-1b
  tags = {
    Name = "dev-proj-private-subnet-${count.index + 1}"
  }
}

#create i internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_proj_1_vpc_ap_south_1.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create the public route table
resource "aws_route_table" "dev_proj_1_public_route_table" {
  vpc_id = aws_vpc.dev_proj_1_vpc_ap_south_1.id
  route {
    cidr_block = "0.0.0.0/0" #request from any application on internet
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "dev-proj-1-public-rt"
  }
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "dev_proj_1_public_rt_subnet_association1" {
  subnet_id      =  aws_subnet.dev_proj_1_public_subnets_1.id
  route_table_id = aws_route_table.dev_proj_1_public_route_table.id
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "dev_proj_1_public_rt_subnet_association2" {
  subnet_id      =  aws_subnet.dev_proj_1_public_subnets_2.id
  route_table_id = aws_route_table.dev_proj_1_public_route_table.id
}


# Create the private route table
resource "aws_route_table" "dev_proj_1_private_route_table" {
  vpc_id = aws_vpc.dev_proj_1_vpc_ap_south_1.id
   tags = {
    Name = "dev-proj-1-private-rt"
  }
}

# Private Route Table and Public Subnet Association
resource "aws_route_table_association" "dev_proj_1_private_rt_subnet_association1" {

  subnet_id      =  aws_subnet.dev_proj_1_private_subnets[0].id
  route_table_id = aws_route_table.dev_proj_1_private_route_table.id
}

# Private  Route Table and Public Subnet Association
resource "aws_route_table_association" "dev_proj_1_private_rt_subnet_association2" {

  subnet_id      =  aws_subnet.dev_proj_1_private_subnets[1].id
  route_table_id = aws_route_table.dev_proj_1_private_route_table.id
}