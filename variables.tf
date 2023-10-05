#Provider
variable "region" {
  type        = string
  description = "VARIABLE DE REGIONS"
  default     = "us-west-2"
}

variable "access_key" {
  type        = string
  description = "Llave de acceso "
  default     = ""
}
variable "secret_key" {
  type        = string
  description = "Llave secreta"
  default     = ""
}

#VPC
variable "availability_zone" {
  type        = string
  description = "Zona de disponibilidad"
  default     = "us-west-2a"
}

variable "cidr_block" {
  type        = string
  description = "Bloque IP para VPC"
  default     = "10.0.0.0/16"
}

variable "subred_publica" {
  type        = string
  description = "Subred publica"
  default     = "10.0.0.0/19"

}

variable "subred_priv_ec2" {
  type        = string
  description = "Subred privada para ec2"
  default     = "10.0.128.0/20"
}

variable "subred_priv_rds" {
  type        = string
  description = "Subred privada para rds"
  default     = "10.0.144.0/20"
}

#EC2
variable "private_subnet_ec2_id" {
  type    = string
  default = "aws_subnet.private_subnet_ec2.id"
}
variable "security_group_id" {
  type    = string
  default = ""
}
variable "ami" {
  type    = string
  default = ""
}

#ALB
variable "vpc" {
  type    = string
  default = "aws_vpc.vpc-atrato.id"
}

variable "public_subnet" {
  type    = string
  default = "aws_subnet.public_subnet.id"
}

#RDS
variable "db_name" {
  type    = string
  default = "atrato"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  default = "atrato"
}

variable "private_subnet_rds" {
  type    = string
  default = "aws_subnet.private_subnet_rds.id"
}

variable "rds_securityG" {
  type    = string
  default = "aws_security_group.rds_security_group.id"
}

#Security groups
variable "allowed_ssh" {
  type    = string
  default = "#Ingresar IPs autorizadas para conectarse por ssh a la EC2"
}