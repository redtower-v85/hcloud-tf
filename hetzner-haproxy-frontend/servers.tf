# skynet-haproxy-2: frontend HAProxy for the Rancher UI (oks01.ci.octostar.com).
# This server was created outside Terraform and is adopted via the import blocks below.
resource "hcloud_server" "haproxy" {
  name        = var.server_name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [data.hcloud_ssh_key.rancher_key.id]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  # Imported server: these are create-time only and cannot be read back from the API,
  # so any "change" would force Terraform to destroy and recreate the server.
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [ssh_keys, image, user_data, public_net]
  }
}

resource "hcloud_server_network" "haproxy" {
  server_id  = hcloud_server.haproxy.id
  network_id = data.hcloud_network.rancher_net.id
  ip         = var.server_ip
}

import {
  to = hcloud_server.haproxy
  id = "123391534"
}

# Import ID format: <server_id>-<network_id>
import {
  to = hcloud_server_network.haproxy
  id = "123391534-12020354"
}
