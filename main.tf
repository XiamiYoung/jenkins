variable "s3_bucket_name" {
  type = string
  default = "young-test-cicd-bucket-12345"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}