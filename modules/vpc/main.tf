resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "Terraform-Subnet"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_cidrs
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "Terraform-Subnet"
  }
}

resource "aws_eip" "this" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_eip.this]
  tags = {
    Name = "Terraform-IGW"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "Terraform-RouteTable"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "Terraform-RouteTable"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}