terraform {
  backend "s3" {
    bucket         = "terraform-state-assorted"
    key            = "tf-aws-module-s3/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-2"
  }
}
