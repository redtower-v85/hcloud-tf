resource "hcloud_server" "nodes" {
  for_each = local.servers

  name        = each.value.name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [data.hcloud_ssh_key.rancher_key.id]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  labels = {
    cluster = "rke2-demo"
    role    = each.value.role
    name    = each.value.name
  }

  # Install Tailscale on boot and join tailnet with tag ssh-server, enable Tailscale SSH
  user_data = sensitive(templatefile("${path.module}/cloud-init-tailscale.yaml.tpl", {
    auth_key = tailscale_tailnet_key.ssh_servers.key
  }))
}

resource "hcloud_server_network" "nodes" {
  for_each = local.servers

  server_id  = hcloud_server.nodes[each.key].id
  network_id = hcloud_network.rke2.id
  ip         = each.value.ip
}

resource "hcloud_firewall_attachment" "nodes" {
  firewall_id = hcloud_firewall.rke2.id
  server_ids  = [for s in hcloud_server.nodes : s.id]
}
