# VPC
resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr
}

# IG
resource "aws_internet_gateway" "test_internet_gateway" {
  vpc_id = aws_vpc.test_vpc.id
}

# Subnets
resource "aws_subnet" "test_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "test_subnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
}

# RT
resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_internet_gateway.id
  }
}

# RTA
resource "aws_route_table_association" "test_route_table_association" {
//  count = 2
  route_table_id = aws_route_table.test_route_table.id
//  subnet_id = aws_subnet.test_subnet.*.id[count.index]
  subnet_id = aws_subnet.test_subnet.id
}

# NI
resource "aws_network_interface" "test_web_server_nic" {
//  count = 2
//  subnet_id = aws_subnet.test_subnet.*.id[count.index]
  subnet_id = aws_subnet.test_subnet.id
  private_ips = ["10.0.1.50"]
  security_groups = [aws_security_group.test_sg.id]
}

# EIP
resource "aws_eip" "test_eip" {
//  count = 2
  vpc = true
//  network_interface = aws_network_interface.test_web_server_nic[count.index].id
  network_interface = aws_network_interface.test_web_server_nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.test_internet_gateway]
}

//# LB
//resource "aws_lb" "test_lb" {
//  name = "testlb"
//  load_balancer_type = "network"
//
//  subnet_mapping {
//    subnet_id = aws_subnet.test_subnet.id
//    allocation_id = aws_eip.test_eip.id
//  }
//}