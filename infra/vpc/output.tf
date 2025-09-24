output "vpc_id" {
  value = aws_vpc.user12-vpc.id
}

output "user12_public_id01" {
  value = aws_subnet.user12-public01.id
}

output "user12_public_id02" {
  value = aws_subnet.user12-public02.id
}

output "user12_private_id01" {
  value = aws_subnet.user12-private01.id
}

output "user12_private_id02" {
  value = aws_subnet.user12-private02.id
}