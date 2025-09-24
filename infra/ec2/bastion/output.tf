output "user12-public-ip" {
  value = aws_instance.user12-bastion.public_ip
}