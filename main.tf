terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "alivpc6" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "Ali_VPC6"
}
}

resource "aws_internet_gateway" "ali_gw2" {
  vpc_id = aws_vpc.alivpc6.id

  tags = {
    Name = "Ali_gw2"
  }
}

resource "aws_subnet" "ali_subnet2" {
  vpc_id     = aws_vpc.alivpc6.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true 

  tags = {
    Name = "ali_subnet2"
  }
}

resource "aws_route_table" "aliRT2" {
  vpc_id = aws_vpc.alivpc6.id
  tags = {
      name = "aliRT4"
  }
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ali_gw2.id
  }
  }
  
  resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ali_subnet2.id
  route_table_id = aws_route_table.aliRT2.id
}
  
  resource "aws_instance" "aliserver20" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ali_subnet2.id
  key_name = "MustafaKP"

  tags = {
    Name = "aliserver20"
  }
}