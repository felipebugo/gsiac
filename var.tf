# AWS Region
variable "region_aws" {
  description = "Região onde os recursos dentro da AWS foram criados"
  type = string
  default = "us-east-1"  
}

variable "rds_name" {
  type    = string
  default = "application"
}

variable "rds_user" {
  type    = string
  default = "challenge"
}

variable "rds_password" {
  type    = string
  default = "challenge123"
}

