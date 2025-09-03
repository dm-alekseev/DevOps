# create VPC
module "aws_web_server_vpc" {
  source                  = "./aws-web-server-vpc"


}

# create EC2
module "aws_web_server_instance" {
  source    = "./aws-web-server-inst"

  #depends_on = [module.aws_web_server_vpc]
  #vpc_id            = .aws_web_server_vpc.vpc_id
  #private_subnet  = ["aws_web_server_vpc.private_subnet.id"]


}

# create DB
module "aws_web_server_rds" {
  #source = "./modules/aws-web-server-rds"
  source               = "./aws-web-server-rds"

}



