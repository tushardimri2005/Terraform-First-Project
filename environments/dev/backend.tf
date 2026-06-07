terraform {
  backend "s3" {
    bucket = "tushar-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
#This is the backend file
#this is the file