resource "openstack_compute_instance_v2" "terraform-lb" {
  name = "terra-wordpress-lb"
  image_name = "${var.image}"
  flavor_name = "${var.flavormicro}"
  user_data = "${file("cloud-init/wordpress-lb.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress.id}" ]
  floating_ip = "${openstack_compute_floatingip_v2.wordpressip.address}"
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
    fixed_ip_v4 = "192.168.42.2"
  }
}
