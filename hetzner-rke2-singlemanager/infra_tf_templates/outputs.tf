output "server_names" {
  value = [for s in hcloud_server.nodes : s.name]
}

output "server_public_ipv4" {
  value = {
    for k, s in hcloud_server.nodes : k => s.ipv4_address
  }
}

output "server_private_ipv4" {
  value = {
    for k, s in hcloud_server_network.nodes : k => s.ip
  }
}

output "manager_public_ip" {
  value = hcloud_server.nodes["rnch01"].ipv4_address
}
