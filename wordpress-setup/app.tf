resource "openstack_compute_instance_v2" "terraform-app" {
  name = "terra-wordpress-app-${count.index+1}"
  count = "3"
  image_name = "${var.image}"
  flavor_name = "${var.flavorsmall}"
  user_data = "${file("cloud-init/wordpress-app_slave.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}" ]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}
