aws_region           = "us-east-1"
allocated_storage    = 10
db_name              = "mydb"
engine               = "mysql"
engine_version       = "8.0"
instance_class       = "db.t3.micro"
username             = "foo"
#password             = "" # Will be overridden by GitHub Actions env
parameter_group_name = "default.mysql8.0"
skip_final_snapshot  = true

tags = {
  Name        = "Rds-mysql-dev"
  Environment = "dev"
}