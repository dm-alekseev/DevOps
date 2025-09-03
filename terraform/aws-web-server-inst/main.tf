resource "aws_instance" "bastion" {
  ami               = "ami-07eef52105e8a2059"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name          = "dalekseev"
  tenancy           = "default"
  #subnet_id         = [aws_subnet.public_subnet.id]
  #security_groups   = [aws_security_group.public_sg.id]
  #security_groups   =[aws_security_group.public_sg.id]
  tags = {
    Name = "var.instance_public"
  }
  #user_data = file("userdata.tpl")
}
resource "aws_instance" "private_server" {
  ami               = "ami-07eef52105e8a2059"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1a"
  key_name          = "dalekseev"
  tenancy           = "default"
  #subnet_id         = var.public_subnet.id
  #subnet_id         = [aws_subnet.private_subnet.id]
  #security_groups   = [aws_security_group.public_sg.id]
  #associate_public_ip_address = false
  
  tags = {
    Name = "private" 
  }  
}


