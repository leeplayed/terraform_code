# Bastion Server 구축
resource "aws_instance" "user12-bastion" {
  ami                         = "ami-077ad873396d76f6a" # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
  instance_type               = "t2.micro"
  subnet_id                   = element(var.public_subnet_id, 0) #subnet_id = var.public_subnet_id[0]
  vpc_security_group_ids      = ["sg-0f87e294c9119658d"] # SSH 보안그룹
  key_name                    = "user12-key"
  associate_public_ip_address = true  #Public IP 할당

  tags = {
    Name = "user12-bastion"
  }
}