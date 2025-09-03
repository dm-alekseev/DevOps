resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "my_nat_gateway"
  }
  #depends_on = [aws_internet_gateway.my_igw]
}