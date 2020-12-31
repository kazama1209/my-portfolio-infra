resource "aws_route53_zone" "tk_portfolio_site" {
  name = "${var.root_domain}"
}

resource "aws_route53_record" "tk_portfolio_site" {
  zone_id = "${aws_route53_zone.tk_portfolio_site.zone_id}"
  name = "${var.site_domain}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.tk_portfolio_site.domain_name}"
    zone_id = "${aws_cloudfront_distribution.tk_portfolio_site.hosted_zone_id}"
    evaluate_target_health = false
  }
}
