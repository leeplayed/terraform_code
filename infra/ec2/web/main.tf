# 단일 WEB Server 구축
resource "aws_instance" "user12-web" {
  ami                         = "ami-077ad873396d76f6a" # Amazon Linux 2023 AMI 2023.8.20250915.0 x86_64 HVM kernel-6.1
  instance_type               = "t2.micro"
  subnet_id                   = element(var.private_subnet_id, 0) #subnet_id = var.public_subnet_id[0]
  vpc_security_group_ids      = ["sg-040df0e1074b79bf9",
                                 "sg-082caad33abce9381",
                                 "sg-0f87e294c9119658d"]
  key_name                    = "user12-key"

  tags = {
    Name = "user12-web"
  }
}