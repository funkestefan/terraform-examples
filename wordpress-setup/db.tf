resource "openstack_compute_instance_v2" "terraform-db" {
  name = "terra-wordpress-db"
  image_name = "${var.image}"
  flavor_name = "${var.flavorsmall}"
  user_data = "${file("cloud-init/wordpress-db.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpressdb.id}" ]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}
