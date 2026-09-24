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

  labels = {
    role = "haproxy"
    name = var.server_name
  }
}

resource "hcloud_server_network" "haproxy" {
  server_id  = hcloud_server.haproxy.id
  network_id = data.hcloud_network.rancher_net.id
  ip         = var.server_ip
}

resource "hcloud_firewall_attachment" "haproxy" {
  firewall_id = hcloud_firewall.haproxy.id
  # skynet-haproxy-2 (managed in ../hetzner-haproxy-frontend) shares this firewall
  server_ids = concat([hcloud_server.haproxy.id], var.extra_firewall_server_ids)
}
