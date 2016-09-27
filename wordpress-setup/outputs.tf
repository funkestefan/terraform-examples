output "Wordpress Loadbalancer Public IP" {
    value = "${openstack_compute_floatingip_v2.wordpressip.address}"
}
