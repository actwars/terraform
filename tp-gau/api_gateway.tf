resource "aws_apigatewayv2_api" "lambda_count_api" {
  name          = var.gw_name
  description   = "API to count the number of visits to the s3 static website"
  protocol_type = "HTTP"

}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_count_api.id
  integration_type = "AWS_PROXY"

  connection_type = "INTERNET"
  description     = "claim and send new count"
  integration_uri = aws_lambda_function.lambda_count.invoke_arn
}

resource "aws_apigatewayv2_route" "example" {
  api_id    = aws_apigatewayv2_api.lambda_count_api.id
  route_key = "GET /count"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.lambda_count_api.id
  name        = "test"
  auto_deploy = true
}

#resource "aws_api_gateway_domain_name" "example" {
#  certificate_arn = aws_acm_certificate_validation.example.certificate_arn
#  domain_name     = "api.example.com"
#}
