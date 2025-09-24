variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "vpv_id" {
  type    = string
  default = "vpc-02d0fc7ea5a4c00d9"
}

variable "public_subnet_id" {
  type    = list(any)
  default = ["subnet-020386520851bb042", "subnet-074e11bf9274e9e20"]
}

variable "private_subnet_id" {
  type    = list(any)
  default = ["subnet-02ca58b5564254598", "subnet-01dec7eee221d6f99"]
}

