## admin host Security Groups

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_admin_1" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_admin.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_admin_2" {
  direction = "egress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_admin.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_admin_3" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "${var.sshallow}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_admin.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_admin_5" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "${var.homenet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_admin.id}"
}
