# Rancher (RKE2) server nodes. These were built by hand and adopted with the
# import blocks below; lifecycle guards stop Terraform from ever rebuilding them.
resource "hcloud_server" "nodes" {
  for_each = var.servers

  name        = each.value.name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [data.hcloud_ssh_key.rancher_key.id]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  # Create-time only attributes that cannot be read back after import;
  # any "change" to them would force a destroy/recreate.
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [ssh_keys, image, user_data, public_net]
  }
}

resource "hcloud_server_network" "nodes" {
  for_each = var.servers

  server_id  = hcloud_server.nodes[each.key].id
  network_id = hcloud_network.rancher.id
  ip         = each.value.ip
}

resource "hcloud_firewall_attachment" "nodes" {
  firewall_id = hcloud_firewall.rancher.id
  server_ids  = [for s in hcloud_server.nodes : s.id]
}

import {
  for_each = var.servers
  to       = hcloud_server.nodes[each.key]
  id       = each.value.id
}

# Import ID format: <server_id>-<network_id>
import {
  for_each = var.servers
  to       = hcloud_server_network.nodes[each.key]
  id       = "${each.value.id}-12020354"
}
