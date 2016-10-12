resource "openstack_compute_instance_v2" "terraform-app" {
  depends_on = ["openstack_compute_instance_v2.terraform-storage-master"]
  name = "terra-wordpress-app${count.index}"
  count = "4"
  image_name = "${var.image}"
  flavor_name = "${var.flavormicro}"
  user_data = "${file("cloud-init/wordpress-appserver.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress_app.id}" ]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}
