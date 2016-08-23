## Examples
tor-relay --- Run a tor relay on openstack with terraform

## Requirements
* terraform -> https://www.terraform.io/
* OpenStack RC file with your credentials and API endpoints 

## Installation
edit variables.tf

  - image 
      - replace it with your openstack glance image name for ubuntu 16.04
  - flavor 
      - replace it wih any matching openstack flavor for instances
  - external gateway 
      - id to your external gateway for your floating-ip pool
  - pool 
      - floating ip pool
  - tenant_name 
      - name of your openstack tenant
  - homeip 
      - allow ssh access to your instance from this ip

edit cloud-init/tor-relay.yaml

  - user
    - there is a user "stefan" being added to the system for my convenience. Change that to whatever you like or remove it entirely.


## running

* source \<openrc file\>
* cd into tor-relay
* terraform apply
