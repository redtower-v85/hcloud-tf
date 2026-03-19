output "server_name" {
  value = hcloud_server.haproxy.name
}

output "server_public_ipv4" {
  value = hcloud_server.haproxy.ipv4_address
}

output "server_private_ipv4" {
  value = hcloud_server_network.haproxy.ip
}

output "network_name" {
  value = data.hcloud_network.rancher_net.name
}
