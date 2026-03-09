variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Hetzner location"
  type        = string
  default     = "nbg1"
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cpx42"
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
  default     = "rancher-net"
}

variable "network_cidr" {
  description = "Private network CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "servers" {
  description = "Server definitions"
  type = map(object({
    name = string
    ip   = string
  }))

  default = {
    rancher01 = { name = "rancher01", ip = "10.0.1.11" }
    rancher02 = { name = "rancher02", ip = "10.0.1.12" }
    rancher03 = { name = "rancher03", ip = "10.0.1.13" }
  }
}
