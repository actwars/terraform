resource "aws_cloudfront_distribution" "cdn" {
  origin {
    origin_id   = var.domaine_name
    domain_name = "${var.bucket_name}.s3.amazonaws.com"
  }
  aliases = ["${var.domaine_name}"]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Le petit site des zouloutes"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.domaine_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
