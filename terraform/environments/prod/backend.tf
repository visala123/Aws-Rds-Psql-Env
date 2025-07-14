terraform {
  backend "s3" {
    bucket = "terraform-remote-state-v"
    key    = "terraform.tfstate.prod.Rds-mysql"
    region = "us-east-1"
  }
}
