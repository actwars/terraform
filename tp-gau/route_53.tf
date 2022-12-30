resource "aws_route53_zone" "main" {
  name = var.domaine_name
}

resource "aws_route53_record" "create-type-a" {
  zone_id = "aws_route53_zone.${var.domaine_name}.zone_id"
  name    = var.domaine_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = true
  }
}
