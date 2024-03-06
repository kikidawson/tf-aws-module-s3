resource "aws_s3_bucket" "this" {
# checkov:skip=CKV_AWS_144:TODO enable cross region replication
# checkov:skip=CKV2_AWS_62:TODO event notifications
# checkov:skip=CKV2_AWS_65:TODO ACL disabled
# checkov:skip=CKV_AWS_18:TODO configure logging
# checkov:skip=CKV2_AWS_61:TODO configure lifecycle

  bucket        = var.name
  force_destroy = var.force_destroy

  tags = {
    Name = var.name
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.policy_document_json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    bucket_key_enabled = var.sse_bucket_key_enabled

    apply_server_side_encryption_by_default {
      kms_master_key_id = local.sse_aws_kms ? var.kms_key_arn : null
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]

  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_configuration_enabled
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = local.enable_static_website ? 1 : 0

  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.website_file_name
  }
}

resource "aws_s3_object" "static_webpage" {
  count = local.enable_static_website ? 1 : 0

  bucket = aws_s3_bucket.this.id
  key    = var.website_file_name
  source = "./src/${var.website_file_name}"
}
