resource "aws_s3_bucket" "tk_portfolio_site" {
  bucket = "${var.bucket_name}"
  acl = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "tk_portfolio_site" {
  bucket = "${aws_s3_bucket.tk_portfolio_site.id}"
  policy = "${data.aws_iam_policy_document.s3_site_policy.json}"
}

data "aws_iam_policy_document" "s3_site_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.tk_portfolio_site.arn}/*"]

    principals {
      type = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.tk_portfolio_site.iam_arn}"]
    }
  }
}
