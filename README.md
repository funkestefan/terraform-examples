## Examples
tor-reloy --- Run a tor relay on openstack with terraform

## Requirements
* terraform -> https://www.terraform.io/
* OpenStack RC file with your credentials and API endpoints 

## Installation
edit variables.tf

  image = replace it with your openstack glance image name for ubuntu 16.04
  flavor = replace it wih any matching openstack flavor for instances
  external gateway = id to your external gateway for your floating-ip pool
  pool = floating ip pool
  tenant_name = name of your openstack tenant
  homeip = allow ssh access to your instance from this ip

source <openrc file>
terraform apply
