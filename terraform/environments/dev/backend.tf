terraform {
  backend "s3" {
    bucket = "terraform-remote-state-v"
    key    = "terraform.tfstate.dev.Rds-mysql"
    region = "us-east-1"
  }
}

