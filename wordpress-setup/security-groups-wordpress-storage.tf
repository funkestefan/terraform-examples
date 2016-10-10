## app server Security Groups

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app1" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "${var.localnet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app2" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app3" {
  direction = "egress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app4" {
  # HTTPs
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 443
  port_range_max = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app5" {
  # HTTP
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 80
  port_range_max = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

## glusterfs rules
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app_gfs1" {
  # portmap/rpcbind
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 111
  port_range_max = 111
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app_gfs2" {
  # portmap/rpcbind
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "udp"
  port_range_min = 111
  port_range_max = 111
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app_gfs3" {
  # glusterfs daemon/management
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 24007
  port_range_max = 24008
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app_gfs4" {
  # glusterfs nfs service
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 38465
  port_range_max = 38467
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_app_gfs5" {
  # glusterfs bricks
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 49152
  port_range_max = 49155
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}"
}
