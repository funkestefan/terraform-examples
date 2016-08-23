output "Tor Relay IP" {
    value = "${openstack_compute_floatingip_v2.torip.address}"
}
