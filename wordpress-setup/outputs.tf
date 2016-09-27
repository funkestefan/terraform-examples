output "Wordpress Loadbalancer Public IP (HTTP/HTTPs)" {
    value = "${openstack_compute_floatingip_v2.wordpressip.address}"
}

output "Wordpress Admin Host Public IP (SSH)" {
    value = "${openstack_compute_floatingip_v2.adminip.address}"
}
