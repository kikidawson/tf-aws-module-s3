terraform {
  backend "s3" {
    bucket         = "terraform-state-assorted"
    key            = "terraform-modules/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-2"
  }
}
