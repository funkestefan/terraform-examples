resource "openstack_compute_instance_v2" "terraform-storage-slave" {
  name = "terra-wordpress-storage-slave${count.index}"
  count = "1"
  image_name = "${var.image}"
  flavor_name = "${var.flavormicro}"
  user_data = "${file("cloud-init/wordpress-storage-slave.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}" ]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}
