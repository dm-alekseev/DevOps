variable "aws_region" {
  default = "eu-central-1"
}

variable "instance_public" {
  description = "Value of the Name tag for the EC1 instance"
  type        = string
  default     = "BastionInstance"
}