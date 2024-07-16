resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}


################### PUBLIC SUBNETS ###################
# 2 public subnets, one for each AZ
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_1_cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public1"
    }
}

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_2_cidr
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "public2"
    }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }


    tags = {
        Name = "public"
    }
}
  

resource "aws_route_table_association" "public1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.public.id
}


################### PRIVATE SUBNETS ###################
# 2 private subnets, one for each AZ

resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_1_cidr
    availability_zone = "us-east-1a"
    tags = {
        Name = "private1"
    }
}
resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_2_cidr
    availability_zone = "us-east-1b"
    tags = {
        Name = "private2"
    }
}

resource "aws_eip" "eip" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public1.id

    tags = {
        Name = "nat"
    }
}


resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "private"
    }
}


resource "aws_route_table_association" "private1" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.private.id
}
