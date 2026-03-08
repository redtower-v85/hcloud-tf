variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Hetzner location"
  type        = string
  default     = "hel1"
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cx33"
}

variable "image" {
  description = "Server image"
  type        = string
  default     = "ubuntu-24.04"
}

variable "ssh_key_name" {
  description = "Existing Hetzner SSH key name"
  type        = string
  default     = "ranchertest01"
}

variable "network_name" {
  description = "Hetzner private network name"
  type        = string
  default     = "rke2-net"
}

variable "network_cidr" {
  description = "Private network CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.10.1.0/24"
}

variable "servers" {
  description = "Server definitions"
  type = map(object({
    name = string
    role = string
    ip   = string
  }))

  default = {
    rnch01 = { name = "rnch01", role = "manager", ip = "10.10.1.11" }
    rnch02 = { name = "rnch02", role = "worker",  ip = "10.10.1.12" }
    rnch03 = { name = "rnch03", role = "worker",  ip = "10.10.1.13" }
    rnch04 = { name = "rnch04", role = "worker",  ip = "10.10.1.14" }
  }
}
