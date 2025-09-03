resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id
  
  route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.my_igw.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}