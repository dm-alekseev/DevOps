resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  #cidr_block              = var.private_subnets_cidr
  availability_zone       = "eu-central-1a" 
  map_public_ip_on_launch = true
  tags = {
    Name = "private_subnet"
  }
}