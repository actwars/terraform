resource "aws_dynamodb_table" "dynamo_static_count" {
  name           = "count_visit"
  hash_key       = "time_stamp"
  read_capacity  = 10
  write_capacity = 10

  attribute {
    name = "time_stamp"
    type = "N"
  }
}
