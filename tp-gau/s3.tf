resource "aws_s3_bucket" "site" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.site.bucket
  for_each     = fileset("${var.file_site_dir}", "**")
  key          = each.value
  source       = "${var.file_site_dir}${each.value}"
  content_type = lookup(tomap(local.mime_types), element(split(".", each.key), length(split(".", each.key)) - 1))
  etag         = filemd5("${var.file_site_dir}${each.value}")
  acl          = "public-read"

}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.site.bucket
  policy = file("policy/policy_s3.json")
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  index_document {
    suffix = "index.html"
  }
}
