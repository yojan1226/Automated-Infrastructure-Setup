variable "vpc_name" {
    type = string
    description = "Name of the VPC"
    default = "dev_proj_1_vpc"
}

variable "vpc_cidr" {
    type = string
    description = "CIDR Block for main VPC"
    default = "30.0.0.0/16"
}

variable "cidr_public_subnet" {
  type = list(string)
  description = "public subnet"

}

variable "availability_zone" {
  type = list(string)
  description = "availability zone"
}

variable "cidr_private_subnet" {
  type = list(string)
  description = "private subnet"
}
