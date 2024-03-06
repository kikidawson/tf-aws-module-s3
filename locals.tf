locals {
  sse_aws_kms           = var.sse_algorithm == "aws:kms"
  enable_static_website = var.website_file_name != null
}
