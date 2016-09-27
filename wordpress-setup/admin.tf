resource "openstack_compute_instance_v2" "terraform-admin" {
  name = "terra-wordpress-admin"
  image_name = "${var.image}"
  flavor_name = "${var.flavormicro}"
  user_data = "${file("cloud-init/wordpress-admin.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress_admin.id}" ]
  floating_ip = "${openstack_compute_floatingip_v2.adminip.address}"
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
    fixed_ip_v4 = "192.168.42.2"
  }
}
