

variable "aws_region" {
  default = "eu-central-1"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  #type        = list(any)
  type = string
  default     = "10.0.1.0/24"
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  #type        = list(any)
   type = string
   default    = "10.0.2.0/24"
  #default     = ["10.0.16.0/20", "10.0.144.0/20"]
  description = "CIDR block for Private Subnet"
}