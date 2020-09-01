output "aws_s3_bucket_name" {
  value = "${module.aws_s3-bucket-dfds-app.bucket_domain_name}"
}
