resource "aws_route53_zone" "main" {
  name = var.domaine_name
}

resource "aws_route53_record" "create-type-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domaine_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = true
  }
}

#resource "aws_route53_record" "gw_zone" {
#  zone_id = aws_route53_zone.main.id
#  name    = var.domaine_name
#  type    = "A"
#
#  alias {
#    evaluate_target_health = true
#    name                   = aws_api_gateway_domain_name.example.cloudfront_domain_name
#    zone_id                = aws_api_gateway_domain_name.example.cloudfront_zone_id
#  }
#}
