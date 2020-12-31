resource "aws_acm_certificate" "cert" {
  provider = "aws"
  domain_name = "${var.root_domain}"
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.root_domain}"]
}

resource "aws_route53_record" "cert_validation" {
  name = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  type = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  zone_id = "${aws_route53_zone.tk_portfolio_site.id}"
  ttl = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}
