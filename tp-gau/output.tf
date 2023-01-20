output "s3_website_endpoint" {
  value = aws_s3_bucket.site.website_endpoint
}

output "hosted_zone_id" {
  value = aws_s3_bucket.site.hosted_zone_id
}
output "api_name" {
  value = aws_apigatewayv2_api.lambda_count_api.id
}
output "api_endpoint" {
  value = aws_apigatewayv2_stage.api_stage.invoke_url
}
