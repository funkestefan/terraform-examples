## storage server Security Groups

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage1" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "${var.localnet}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage2" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage3" {
  direction = "egress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage4" {
  # HTTPs
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 443
  port_range_max = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage5" {
  # HTTP
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 80
  port_range_max = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

## glusterfs rules
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage_gfs1" {
  # portmap/rpcbind
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 111
  port_range_max = 111
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage_gfs2" {
  # portmap/rpcbind
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "udp"
  port_range_min = 111
  port_range_max = 111
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage_gfs3" {
  # glusterfs daemon/management
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 24007
  port_range_max = 24008
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage_gfs4" {
  # glusterfs nfs service
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 38465
  port_range_max = 38467
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_storage_gfs5" {
  # glusterfs bricks
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 49152
  port_range_max = 49155
  remote_ip_prefix = "192.168.42.0/24"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}"
}
