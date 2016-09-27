## Tor Relay Node

resource "openstack_networking_secgroup_v2" "secgroup_wordpress" {
  name = "terra-secgroup_wordpress"
  description = "Security Group for wordpress node"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "${var.sshallow}"
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
