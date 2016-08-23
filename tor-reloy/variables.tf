variable "image" {
    default = "Ubuntu Server 16.04 LTS"
}

variable "flavor" {
    default = "m1.micro"
}

variable "external_gateway" {
    default = "caf8de33-1059-4473-a2c1-2a62d12294fa"
}

variable "pool" {
    default = "ext-net"
}

variable "tenant_name" {
    default = "syseleveneigenbedarf-syseleven-employee-sfunke"
}

variable "homeip" {
    default ="91.66.60.79/32"
}
