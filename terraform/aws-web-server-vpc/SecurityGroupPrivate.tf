resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "private_sg"
  }
  
  egress {
    description = "Outgoing & Incoming ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "80"     
  }

  ingress {
    description     = "Incoming & Outgoing SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
	
	#########################
    #from_port   = 0
    #to_port     = 0
    #protocol    = "-1"
    #cidr_blocks = []
	##########################
  
}