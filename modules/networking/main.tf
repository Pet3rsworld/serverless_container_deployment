# 1. VPC
resource "aws_vpc" "fintech_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-fintech-vpc"
  }
}

# 2. Public Subnets
resource "aws_subnet" "pub_sub" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.fintech_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    name = "${var.project_name}-pub-sub-${count.index + 1}"
  }
}

# 3. Private Subnets
resource "aws_subnet" "pri_sub" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.fintech_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    name = "${var.project_name}-pri_sub-${count.index + 1}"
  }
}

# 4. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.fintech_vpc.id

  tags = {
    name = "${var.project_name}-igw"
  }
}

# 5. Public Route Table
resource "aws_route_table" "pu_rt" {
  vpc_id = aws_vpc.fintech_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    name = "${var.project_name}-pu-rt"
  }
}

# 6. Associate route table 
resource "aws_route_table_association" "rt_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.pub_sub[count.index].id
  route_table_id = aws_route_table.pu_rt.id
}
