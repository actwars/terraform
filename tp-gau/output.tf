output "s3_website_endpoint" {
  value = aws_s3_bucket.site.website_endpoint
}

output "hosted_zone_id" {
  value = aws_s3_bucket.site.hosted_zone_id
}
