# ACM Certificate
resource "aws_acm_certificate" "app_cert" {
  domain_name       = var.app_domain
  validation_method = "DNS"
}
resource "aws_acm_certificate_validation" "app_cert_validation" {
  certificate_arn = aws_acm_certificate.app_cert.arn
  validation_record_fqdns = [
    aws_route53_record.app_validation.fqdn,
  ]
}

# DNS Records
resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.app_domain
  type    = "A"
  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}

# BI tool CNAME
resource "aws_route53_record" "bi" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.bi_domain
  type    = "CNAME"
  ttl     = 300
  records = [aws_instance.bi_instance.public_dns]
}