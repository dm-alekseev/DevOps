# Create RDS

variable "allocated_storage" {
  type    = string
  default = "20"
}

variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0.28"
}

variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}

variable "db_name" {
  type    = string
  default = "my_RDS_database"
}

variable "username" {
  type    = string
  default = "*******"
}

variable "password" {
  type    = string
  default = "*******"
}

variable "skip_final_snapshot" {
  type    = bool
  default = "true"
}

variable "db_subnet_group_name" {
  type    = string
  default = "rds_database_subnet"
}

variable "subnet_group_tag" {
  type    = string
  default = "rds_databse_saabnet"
}
