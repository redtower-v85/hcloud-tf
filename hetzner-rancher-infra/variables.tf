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
  description = "Rancher server nodes (Hetzner server ID, name, rancher-net IP)"
  type = map(object({
    id   = string
    name = string
    ip   = string
  }))

  default = {
    skynet_rancher_01 = { id = "123421703", name = "skynet-rancher-01", ip = "10.0.1.4" }
    skynet_rancher_02 = { id = "123421704", name = "skynet-rancher-02", ip = "10.0.1.2" }
    skynet_rancher_03 = { id = "123421705", name = "skynet-rancher-03", ip = "10.0.1.3" }
  }
}
