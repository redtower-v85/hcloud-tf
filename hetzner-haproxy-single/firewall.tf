# Firewall for the HAProxy nodes (skynet-haproxy-1 and skynet-haproxy-2).
# Tailnet-only: every service (SSH, 80/443, 6443, 9345, stats) is reached over
# Tailscale, whose traffic is encrypted inside UDP and never hits these rules
# after decapsulation. Nothing is exposed on the public IPs.
# Do NOT add "any port from 0.0.0.0/0" rules in the console: that exposed the
# Rancher UI, HAProxy stats and the K8s API to the internet (found 2026-09-24).
resource "hcloud_firewall" "haproxy" {
  name = "haproxy-single-fw"

  # Tailscale direct (peer-to-peer) connections; without it traffic falls back to DERP relays
  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "41641"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # rancher-net: RKE2 nodes joining via 10.0.1.21:9345 and HAProxy backends
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "any"
    source_ips = ["10.0.0.0/16"]
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "any"
    source_ips = ["10.0.0.0/16"]
  }
}
