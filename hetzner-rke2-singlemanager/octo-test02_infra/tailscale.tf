# Reusable auth key so all servers join the tailnet with tag "ssh-server"
resource "tailscale_tailnet_key" "ssh_servers" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  description   = "Hetzner RKE2 servers ssh-server"
  tags          = ["tag:ssh-server"]
}
