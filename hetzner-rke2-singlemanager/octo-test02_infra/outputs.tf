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
  value = hcloud_server.nodes["node01"].ipv4_address
}

# After running 'tofu destroy', remove these nodes from the Tailscale admin console (https://login.tailscale.com/admin/machines). Run 'tofu output -raw tailscale_nodes_to_remove_after_destroy' before destroy to save the list.
output "tailscale_nodes_to_remove_after_destroy" {
  description = "Node names registered in Tailscale (tag: ssh-server). After 'tofu destroy', remove these from https://login.tailscale.com/admin/machines"
  value       = [for s in local.servers : s.name]
}
