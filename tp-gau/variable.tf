variable "region" {
  type    = string
  default = "us-east-1"
}
variable "bucket_name" {
  type    = string
  default = "zoulouterie-static-website"
}
variable "file_site_dir" {
  type    = string
  default = "./site/"
}
#variable "policy_s3" {
#  type    = string
#  default = "file("policy/policy_s3.json")"
#}
variable "domaine_name" {
  type    = string
  default = "www.zoulouterie.link"
}
variable "gw_name" {
  type    = string
  default = "lambda_count_gw_api"
}
variable "lambda_zip" {
  type    = string
  default = "./lambda/add_and_count.zip"
}
variable "lambda_handler" {
  type    = string
  default = "index.handler"
}
