variable "aws_region" {
  description = "AWS region to deploy resources in"
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  default     = "akankssha-s3-bucket"
}
