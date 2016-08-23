provider "openstack" {
  tenant_name = "${var.tenant_name}"
}

resource "openstack_networking_network_v2" "terraform" {
  name = "terra-tor-net0"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "terraform" {
  name = "terra-tor-net-sub0"
  network_id = "${openstack_networking_network_v2.terraform.id}"
  cidr = "192.168.42.0/24"
  allocation_pools {
    start = "192.168.42.100"
    end = "192.168.42.200"
  }
  ip_version = 4
  dns_nameservers = ["8.8.8.8","8.8.4.4"]
}

resource "openstack_networking_router_v2" "terraform" {
  name = "terra-tor-net-router0"
  admin_state_up = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "terraform" {
  router_id = "${openstack_networking_router_v2.terraform.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform.id}"
}

resource "openstack_compute_floatingip_v2" "torip" {
  pool = "${var.pool}"
  depends_on = ["openstack_networking_router_interface_v2.terraform"]
}

resource "openstack_compute_instance_v2" "terraform-tornode" {
  name = "terra-tor-relay"
  image_name = "${var.image}"
  flavor_name = "${var.flavor}"
  # key_pair = "${openstack_compute_keypair_v2.terraform.name}"
  user_data = "${file(\"cloud-init/tor-relay.yaml\")}"
  security_groups = [ "${openstack_networking_secgroup_v2.secgroup_tor.id}" ]
  floating_ip = "${openstack_compute_floatingip_v2.torip.address}"
  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }
}

