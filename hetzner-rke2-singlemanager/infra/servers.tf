resource "hcloud_server" "nodes" {
  for_each = var.servers

  name        = each.value.name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [data.hcloud_ssh_key.rancher_key.id]

  labels = {
    cluster = "rke2-demo"
    role    = each.value.role
    name    = each.value.name
  }
}

resource "hcloud_server_network" "nodes" {
  for_each = var.servers

  server_id  = hcloud_server.nodes[each.key].id
  network_id = hcloud_network.rke2.id
  ip         = each.value.ip
}

resource "hcloud_firewall_attachment" "nodes" {
  firewall_id = hcloud_firewall.rke2.id
  server_ids  = [for s in hcloud_server.nodes : s.id]
}
