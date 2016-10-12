## load balancer Security Groups

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "${var.localnet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction = "egress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  # HTTPs
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 443
  port_range_max = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_5" {
  # HTTP
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 80
  port_range_max = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_6" {
  # HTTP
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 8080
  port_range_max = 8080
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

## Consul
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_lb_consul_1" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 8300
  port_range_max = 8302
  remote_ip_prefix = "${var.localnet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_lb_consul_2" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "udp"
  port_range_min = 8300
  port_range_max = 8302
  remote_ip_prefix = "${var.localnet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_lb_consul_3" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "udp"
  port_range_min = 8600
  port_range_max = 8600
  remote_ip_prefix = "${var.localnet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress.id}"
}
