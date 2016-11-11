# Cloudflare - oe

resource "cloudflare_record" "cloudflarerecord_lb_domain1" {
  domain = "${var.cloudflare_domain1}"
  name = "${var.cloudflare_host_lb}"
  value = "${openstack_compute_floatingip_v2.wordpressip.address}"
  type = "A"
  ttl = 7200
}

resource "cloudflare_record" "cloudflarerecord_admin_domain1" {
  domain = "${var.cloudflare_domain1}"
  name = "${var.cloudflare_host_admin}"
  value = "${openstack_compute_floatingip_v2.adminip.address}"
  type = "A"
  ttl = 7200
}

# cloudflare - ö

resource "cloudflare_record" "cloudflarerecord_lb_domain2" {
  domain = "${var.cloudflare_domain2}"
  name = "${var.cloudflare_host_lb}"
  value = "${openstack_compute_floatingip_v2.wordpressip.address}"
  type = "A"
  ttl = 7200
}

resource "cloudflare_record" "cloudflarerecord_admin_domain2" {
  domain = "${var.cloudflare_domain2}"
  name = "${var.cloudflare_host_admin}"
  value = "${openstack_compute_floatingip_v2.adminip.address}"
  type = "A"
  ttl = 7200
}
