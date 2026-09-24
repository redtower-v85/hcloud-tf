# Tailnet-only: SSH, 443, 6443, 9345 etc. are reached over Tailscale and never
# exposed on the public IPs. Do NOT add "any port from 0.0.0.0/0" rules in the
# console; that exposed the RKE2 join port and kubelet to the internet (2026-09-24).
resource "hcloud_firewall" "rancher" {
  name = "rancher-fw"

  rule {
    description = "Tailscale direct"
    direction   = "in"
    protocol    = "udp"
    port        = "41641"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    description = "rancher-net"
    direction   = "in"
    protocol    = "tcp"
    port        = "any"
    source_ips  = [var.network_cidr]
  }

  rule {
    description = "rancher-net"
    direction   = "in"
    protocol    = "udp"
    port        = "any"
    source_ips  = [var.network_cidr]
  }

  # flannel uses the nodes' PUBLIC IPs as VXLAN endpoints; blocking this breaks
  # cross-node pod traffic (Rancher UI outage 2026-09-24).
  rule {
    description = "flannel VXLAN between rancher nodes (uses public IPs)"
    direction   = "in"
    protocol    = "udp"
    port        = "8472"
    source_ips  = [for s in hcloud_server.nodes : "${s.ipv4_address}/32"]
  }
}
