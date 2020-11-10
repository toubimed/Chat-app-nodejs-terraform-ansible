resource "aws_vpc" "app-vpc" {
  cidr_block              = var.VPC_CIDR_BLOCK
  instance_tenancy        = "default"
  enable_dns_support      = "true"
  enable_dns_hostnames    = "true"
  enable_classiclink      = "false"
  tags = {
    Name = var.VPC_NAME
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id                  = "aws_vpc.${var.VPC_NAME}.id"
  cidr_block              = var.SUBNET1_CIDR_BLOCK
  availability_zone       = var.AZ1
  map_public_ip_on_launch = "true"
  tags = {
    Name = var.SUBNET1_NAME
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id                  = "aws_vpc.${var.VPC_NAME}.id"
  cidr_block              = var.SUBNET2_CIDR_BLOCK
  availability_zone       = var.AZ2
  map_public_ip_on_launch = "true"
  tags = {
    Name = var.SUBNET2_NAME
  }
}

resource "aws_internet_gateway" "app-gw" {
  vpc_id                  = "aws_vpc.${var.VPC_NAME}.id"
  tags = {
    Name = var.GW_NAME
  }
}

resource "aws_route_table" "app-route" {
    vpc_id                = "aws_vpc.${var.VPC_NAME}.id"
    route{
      cidr_block          = "0.0.0.0/0"
      gateway_id          = "aws_internet_gateway.${var.GW_NAME}.id"
    }
    tags = {
      Name = var.ROUTE_NAME
    }
}

resource "aws_route_table_association" "app-ass-1" {
  subnet_id               = "aws_subnet.${var.SUBNET1_NAME}.id"
  route_table_id          = "aws_route_table.${var.ROUTE_NAME}.id"
}

resource "aws_route_table_association" "app-ass-2" {
  subnet_id               = "aws_subnet.${var.SUBNET2_NAME}.id"
  route_table_id          = "aws_route_table.${var.ROUTE_NAME}.id"
}
