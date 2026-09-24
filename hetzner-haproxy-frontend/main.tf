provider "hcloud" {
  token = var.hcloud_token
}

# SSH key for server access (default: ranchertest01)
data "hcloud_ssh_key" "rancher_key" {
  name = var.ssh_key_name
}

# Use existing rancher-net network (created by hetzner-rancher-infra or similar)
data "hcloud_network" "rancher_net" {
  name = var.network_name
}
