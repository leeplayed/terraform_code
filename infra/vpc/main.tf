resource "aws_vpc" "user12-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "user12-vpc"
  }
}