variable "block_public_acls" {
  description = "Whether S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether S3 should block public policies for this bucket."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Whether to delete all objects, including locked, when bucket is destroyed."
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key used to encrypt pbjects in the bucket."
  type        = string
  default     = null
}

variable "policy_document_json" {
  description = "The JSON policy document to be attached as the bucket policy."
  type        = string
}

variable "restrict_public_buckets" {
  description = "Whether S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "object_ownership" {
  description = "Object ownership for S3 buckets ownership control rules."
  type        = string
  default     = "BucketOwnerPreferred"

  validation {
    condition     = contains(["BucketOwnerPreferred", "ObjectWriter", "BucketOwnerEnforced"], var.object_ownership)
    error_message = "Object ownership must be one of the following; BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced."
  }
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use. Valid values are AES256, aws:kms, and aws:kms:dsse"
  type        = string
  default     = "aws:kms"

  validation {
    condition     = contains(["AES256", "aws:kms", "aws:kms:dsse"], var.sse_algorithm)
    error_message = "SSE Algorithm must be one of the following; AES256, aws:kms, and aws:kms:dsse."
  }
}

variable "sse_bucket_key_enabled" {
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
  type        = bool
  default     = null
}

variable "versioning_configuration_enabled" {
  description = "Versioning state of the bucket."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning_configuration_enabled)
    error_message = "Versioning configuration must be one of the following; Enabled, Suspended or Disabled."
  }
}

variable "website_file_name" {
  description = "The file name of the index page for the S3 static website."
  type        = string
  default     = null
}
