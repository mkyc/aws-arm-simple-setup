resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name           = "${var.name}-vpc"
    resource_group = var.name
    creator        = var.creator
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name           = "${var.name}-gw"
    resource_group = var.name
    creator        = var.creator
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr

  tags = {
    Name           = "${var.name}-subnet"
    resource_group = var.name
    creator        = var.creator
  }
}

resource "aws_eip" "eip" {
  vpc = true

  instance = aws_instance.vm.id

  tags = {
    Name           = "${var.name}-eip"
    resource_group = var.name
    creator        = var.creator
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name           = "${var.name}-rt"
    resource_group = var.name
    creator        = var.creator
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
  name   = "${var.name}-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name           = "${var.name}-sg"
    resource_group = var.name
    creator        = var.creator
  }
}
