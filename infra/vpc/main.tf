# VPC 생성
resource "aws_vpc" "user12-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "user12-vpc"
  }
}

# subnet 생성
resource "aws_subnet" "user12-public01" {
  vpc_id            = aws_vpc.user12-vpc.id     # VPC ID
  cidr_block        = var.public_subnet_cidr[0] # 서브넷 CIDR 블록
  availability_zone = var.azs[0]                # 가용 영역

  tags = {
    Name = "user12-public01"
  }
}

resource "aws_subnet" "user12-public02" {
  vpc_id            = aws_vpc.user12-vpc.id     # VPC ID
  cidr_block        = var.public_subnet_cidr[1] # 서브넷 CIDR 블록
  availability_zone = var.azs[1]                # 가용 영역

  tags = {
    Name = "user12-public02"
  }
}

resource "aws_subnet" "user12-private01" {
  vpc_id            = aws_vpc.user12-vpc.id      # VPC ID
  cidr_block        = var.private_subnet_cidr[0] # 서브넷 CIDR 블록
  availability_zone = var.azs[0]                 # 가용 영역

  tags = {
    Name = "user12-private01"
  }
}

resource "aws_subnet" "user12-private02" {
  vpc_id            = aws_vpc.user12-vpc.id      # VPC ID
  cidr_block        = var.private_subnet_cidr[1] # 서브넷 CIDR 블록
  availability_zone = var.azs[1]                 # 가용 영역

  tags = {
    Name = "user12-private02"
  }
}

# Internet Gateway 생성
resource "aws_internet_gateway" "user12-igw" {
  vpc_id = aws_vpc.user12-vpc.id

  tags = {
    Name = "user12-igw"
  }
}

# EIP 생성 (고정 IP)
resource "aws_eip" "user12-eip" {
  domain     = "vpc" # vpc에서 사용하겠다는 의미
  #depends_on = [ "aws_internet_gateway.user12-igw" ]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "user12-eip"
  }
}

# NAT Gateway 생성
resource "aws_nat_gateway" "user12-nat-gw" {
  allocation_id = aws_eip.user12-eip.id
  subnet_id     = aws_subnet.user12-public01.id
  depends_on    = [ "aws_internet_gateway.user12-igw" ]
  tags = {
    Name = "user12-nat-gw"
  }
}

# PublicRoute Table 생성
resource "aws_default_route_table" "user12-public-rt" {
  default_route_table_id = aws_vpc.user12-vpc.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.user12-igw.id
  }
  tags = {
    Name = "user12-public-rt" 
  }
}

# Public Subnet과 Route Table 연결
resource "aws_route_table_association" "user12-public01-rt-assoc" {
  subnet_id      = aws_subnet.user12-public01.id
  route_table_id = aws_default_route_table.user12-public-rt.id
}
resource "aws_route_table_association" "user12-public02-rt-assoc" {
  subnet_id      = aws_subnet.user12-public02.id
  route_table_id = aws_default_route_table.user12-public-rt.id
}

# Private Route Table 생성
resource "aws_route_table" "user12-private-rt" {
  vpc_id = aws_vpc.user12-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.user12-nat-gw.id
  }
  tags = {
    Name = "user12-private-rt"
  }
}

# Private Subnet과 Route Table 연결
resource "aws_route_table_association" "user12-private01-rt-assoc" {
  subnet_id      = aws_subnet.user12-private01.id
  route_table_id = aws_route_table.user12-private-rt.id
}
resource "aws_route_table_association" "user12-private02-rt-assoc" {
  subnet_id      = aws_subnet.user12-private02.id
  route_table_id = aws_route_table.user12-private-rt.id
}

