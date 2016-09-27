resource "openstack_compute_instance_v2" "terraform-admin" {
  name = "terra-wordpress-admin"
  image_name = "${var.image}"
  flavor_name = "${var.flavormicro}"
  user_data = "${file("cloud-init/wordpress-admin.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress.id}" ]
  floating_ip = "${openstack_compute_floatingip_v2.wordpressip.address}"
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}
