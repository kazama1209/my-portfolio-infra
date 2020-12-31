output "cloud_front_destribution_domain_name" {
  value = "${aws_cloudfront_distribution.tk_portfolio_site.domain_name}"
}

output "zone_name_servers" {
  value = "${aws_route53_zone.tk_portfolio_site.name_servers}"
}
