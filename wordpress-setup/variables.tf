variable "image" {
    default = "Ubuntu Server 16.04 LTS"
}

variable "flavormicro" {
    default = "m1.micro"
}

variable "flavorsmall" {
    default = "m1.small"
}

variable "external_gateway" {
    default = "caf8de33-1059-4473-a2c1-2a62d12294fa"
}

variable "pool" {
    default = "ext-net"
}

variable "tenant_name" {
    default = "syseleveneigenbedarf-sfunke-sf-techdemo"
    # default = "syseleveneigenbedarf-syseleven-employee-sfunke"
}

variable "sshallow" {
    default = "151.252.43.0/24"
}

variable "localnet" {
    default = "192.168.42.0/24"
}

variable "homenet" {
    default = "91.65.253.4/32"
}

variable "db_volume" {
    default = "8d265a06-07c0-403c-97f1-2b05e127a28e"
}
