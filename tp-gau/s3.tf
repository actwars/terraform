resource "aws_s3_bucket" "site" {
  bucket        = var.bucket_name
  force_destroy = true
}
resource "aws_s3_object" "object" {
  bucket   = var.bucket_name
  for_each = fileset("${var.file_site_dir}", "**")
  key      = each.value
  source   = "${var.file_site_dir}${each.value}"
  etag     = filemd5("${var.file_site_dir}${each.value}")
  acl      = "public-read"
}
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = var.bucket_name
  policy = file("policy/policy_s3.json")
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = var.bucket_name

  index_document {
    suffix = "index.html"

  }
}
