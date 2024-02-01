terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.27"
    } 
  }
  required_version = ">=0.14.9"
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_subnet" "pub-b" {
  vpc_id            = aws_vpc.customvpc.id
  cidr_block        = "10.0.1.0/24"  # Change the CIDR block
  availability_zone = "us-east-1b"

  tags = {
    Name = "public - b"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.customvpc.id

  tags = {
    Name = "myigw"
  }
}

data "aws_route" "routeigw" {
  route_table_id         = aws_vpc.customvpc.main_route_table_id
  destination_cidr_block = "10.0.0.0/20"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "pub-a" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.0.0/26"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public - a"
  }
}

resource "aws_subnet" "pub-b" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public - b"
  }
}


