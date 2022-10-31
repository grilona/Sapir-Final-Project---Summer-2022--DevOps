terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "Ilona-dev-vpc" {
  cidr_block = "192.168.1.0/27"
  tags = {
    "Name" = "Ilona-dev-vpc"
  }
}

resource "aws_subnet" "Ilona-k8s-subnet" {
  vpc_id     = aws_vpc.Ilona-dev-vpc.id
  cidr_block = "192.168.1.0/27"

  tags = {
    Name = "Ilona-k8s-subnet"
  }
}

resource "aws_internet_gateway" "Ilona_GW" {
  vpc_id = aws_vpc.Ilona-dev-vpc.id

  tags = {
    Name = "Ilona_GW"
  }
}
resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.Ilona-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Ilona_GW.id
}