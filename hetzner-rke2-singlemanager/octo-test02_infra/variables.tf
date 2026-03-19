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
  default     = "cx43"
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

# Base name for servers. You will be prompted on plan/apply if not set (or set TF_VAR_server_name_base).
variable "server_name_base" {
  description = "Base name for cluster nodes. Servers will be named <base>01, <base>02, etc. (e.g. 'rnch' -> rnch01, rnch02, ...)."
  type        = string
}

variable "node_count" {
  description = "Number of nodes (first is manager, rest are workers)"
  type        = number
  default     = 4
}

# Tailscale. You will be prompted on plan/apply if not set (or set TF_VAR_tailscale_api_key).
variable "tailscale_api_key" {
  description = "Tailscale API key for your tailnet (https://login.tailscale.com/admin/settings/keys)."
  type        = string
  sensitive   = true
}
