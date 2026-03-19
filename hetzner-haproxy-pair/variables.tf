variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Hetzner location (nbg1 = Nuremberg)"
  type        = string
  default     = "nbg1"
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
  description = "Existing Hetzner SSH key name for server access (e.g. ranchertest01)"
  type        = string
  default     = "ranchertest01"
}

variable "network_name" {
  description = "Existing private network name to attach to (rancher-net)"
  type        = string
  default     = "rancher-net"
}

variable "servers" {
  description = "HAProxy pair server definitions (private IPs must be in rancher-net subnet)"
  type = map(object({
    name = string
    ip   = string
  }))
  default = {
    haproxy01 = { name = "skynet-haproxy-1", ip = "10.0.1.21" }
    haproxy02 = { name = "skynet-haproxy-2", ip = "10.0.1.22" }
  }
}
