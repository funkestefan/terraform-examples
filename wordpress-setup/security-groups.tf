## Wordpress Security Groups

resource "openstack_networking_secgroup_v2" "secgroup_wordpress" {
  name = "terra-secgroup_wordpress"
  description = "Security Group for wordpress node"
}

resource "openstack_networking_secgroup_v2" "secgroup_wordpressdb" {
  name = "terra-secgroup_wordpressdb"
  description = "Security Group for wordpress database node"
}

resource "openstack_networking_secgroup_v2" "secgroup_wordpress_admin" {
  name = "terra-secgroup_wordpress_admin"
  description = "Security Group for wordpress database node"
}

resource "openstack_networking_secgroup_v2" "secgroup_wordpress_storage" {
  name = "terra-secgroup_wordpress_storage"
  description = "Security Group for wordpress storage nodes"
}

resource "openstack_networking_secgroup_v2" "secgroup_wordpress_app" {
  name = "terra-secgroup_wordpress_app"
  description = "Security Group for wordpress appserver nodes"
}
