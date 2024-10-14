variable "frontend_subnet_id" {
  type = string
}

variable "backend_subnet_id" {
  type = string
}

variable "db_subnet_id" {
  type = string
}

variable "ami" {
  type = string
  default = "ami-04cdc91e49cb06165"
}

variable "vpc_id" {
  type = string
}

variable "public_subnets_ids" {
  type = list(string)
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "PRIVATE_KEY" {
  default = "mykey"
}

variable "PUBLIC_KEY" {
  default = "mykey.pub"
}