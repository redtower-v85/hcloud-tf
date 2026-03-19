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

variable "server_name" {
  description = "HAProxy server name"
  type        = string
  default     = "skynet-haproxy-1"
}

variable "server_ip" {
  description = "Private IP for HAProxy server (must be in rancher-net subnet)"
  type        = string
  default     = "10.0.1.21"
}
