resource "aws_route53_record" "bastion_host_alias" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.project_name}-bh"
  type    = "A"
  ttl     = "${var.route53_cname_ttl}"
  records = [ "${aws_eip.bastion_host.public_ip}" ]
}
