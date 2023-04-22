
resource "aws_acm_certificate" "domain" {
  domain_name       = "*.${var.external_dns_domain_filter}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "domain_cert_dns" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.domain.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.domain.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.domain.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.domain.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "domain_cert_validate" {
  certificate_arn         = aws_acm_certificate.domain.arn
  validation_record_fqdns = [aws_route53_record.domain_cert_dns.fqdn]
}
