output "server_public_ipv4" {
  value = {
    for k, s in hcloud_server.nodes : k => s.ipv4_address
  }
}
