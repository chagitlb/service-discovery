terraform {
  required_version = ">= 0.13"
}
/*
  vpc
*/
resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_vpc
    enable_dns_hostnames = true
    tags ={
        Name = "${var.name}-vpc" 
    }
}

/*
  Public Subnet
*/
resource "aws_subnet" "public-subnet" {
    count = length(var.cidr_public)
    vpc_id = aws_vpc.vpc.id

    cidr_block = var.cidr_public[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true
    tags ={
        Name = "Public Subnet ${count.index}- ${var.name}"
    }
}

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }

    tags ={
        Name = "Public Subnet ${var.name}"
    }
}

resource "aws_route_table_association" "public-association" {
    count = length(aws_subnet.public-subnet.*.id) 
    subnet_id = aws_subnet.public-subnet[count.index].id
    route_table_id = aws_route_table.public-route.id
}

resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.vpc.id
}
