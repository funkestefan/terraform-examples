resource "openstack_compute_instance_v2" "terraform-storage-master" {
  name = "terra-wordpress-storage-master${count.index}"
  count = "1"
  image_name = "${var.image}"
  flavor_name = "${var.flavorsmall}"
  user_data = "${file("cloud-init/wordpress-storage-master.yaml")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_wordpress_storage.id}" ]
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}
