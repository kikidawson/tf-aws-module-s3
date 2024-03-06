output "arn" {
  description = "The S3 bucket ARN."
  value       = aws_s3_bucket.this.arn
}

output "id" {
  description = "The S3 bucket ID."
  value       = aws_s3_bucket.this.id
}
