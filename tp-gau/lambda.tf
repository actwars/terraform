resource "aws_lambda_function" "lambda_count" {
  function_name = "lambda_count"
  runtime       = "nodejs18.x"
  filename      = var.lambda_zip
  handler       = var.lambda_handler
  role          = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = var.lambda_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "lambda_invoke_dynamodb_policy"
  role = aws_iam_role.lambda_exec.id

  policy = file("./policy/lambda_invoke_dynamo.js")
}


resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_count.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_count_api.execution_arn}/*/*"
}
