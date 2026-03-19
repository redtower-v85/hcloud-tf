provider "hcloud" {
  token = var.hcloud_token
}

provider "tailscale" {
  api_key = var.tailscale_api_key
}

data "hcloud_ssh_key" "rancher_key" {
  name = var.ssh_key_name
}

# Build server map from base name: <base>01, <base>02, ... (first = manager, rest = workers).
# Hetzner requires valid hostnames (e.g. start with a letter); use "node" when base is empty.
locals {
  server_name_base = var.server_name_base != "" ? var.server_name_base : "node"
  servers = {
    for i in range(1, var.node_count + 1) :
    "node${format("%02d", i)}" => {
      name = format("%s%02d", local.server_name_base, i)
      role = i == 1 ? "manager" : "worker"
      ip   = "10.10.1.${10 + i}"
    }
  }
}
