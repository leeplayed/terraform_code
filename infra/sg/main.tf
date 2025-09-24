# SSH 보안그룹
resource "aws_security_group" "user12-ssh-accept" {
  name        = "user12-ssh-accept"
  description = "Security group to allow SSH access"
  vpc_id      = var.vpv_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0    # 모든 포트
    to_port     = 0    # 모든 포트
    protocol    = "-1" # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "user12-ssh-accept"
  }
}

# HTTP 보안그룹
resource "aws_security_group" "user12-http-accept" {
  name        = "user12-http-accept"
  description = "Security group to allow HTTP access"
  vpc_id      = var.vpv_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0    # 모든 포트
    to_port     = 0    # 모든 포트
    protocol    = "-1" # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "user12-http-accept"
  }
}

# HTTPS 보안그룹
resource "aws_security_group" "user12-https-accept" {
  name        = "user12-https-accept"
  description = "Security group to allow HTTPS access"
  vpc_id      = var.vpv_id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0    # 모든 포트
    to_port     = 0    # 모든 포트
    protocol    = "-1" # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "user12-https-accept"
  }
}