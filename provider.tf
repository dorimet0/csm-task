# Configure the AWS Provider
provider "aws" {
  access_key = "put your key here"
  secret_key = "put your secret key here"
  version = "~> 2.0"
  region  = "us-east-1"
}