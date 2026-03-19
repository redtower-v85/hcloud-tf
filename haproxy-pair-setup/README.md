# HAProxy pair setup for RKE2 (Tailnet)

This folder contains the **operational plan and config** for the HAProxy pair created by `../hetzner-haproxy-pair/` Terraform. Use it after the two servers are provisioned.

## Architecture

- **2× HAProxy nodes** (e.g. `haproxy01`, `haproxy02`) on Hetzner in Nuremberg (nbg1), cx33, attached to **rancher-net**, no IPv6.
- **RKE2 cluster** nodes and HAProxy nodes are all on **Tailscale (tailnet)**. Prefer using Tailnet hostnames or Tailscale IPs (100.x) for RKE2 API backends so traffic stays on tailnet when possible.
- HAProxy exposes:
  - **6443** → RKE2 Kubernetes API
  - **80** / **443** → optional HTTP/HTTPS (e.g. Rancher/Ingress) to RKE2 backends

## Prerequisites

1. **Terraform**: 2 servers and firewall from `../hetzner-haproxy-pair/` applied; `rancher-net` must already exist.
2. **Tailscale**: Install and authenticate Tailscale on both HAProxy nodes and all RKE2 nodes so they can reach each other via tailnet (e.g. `rke2-server-01`, `rke2-server-02`, …).

## High-level steps

1. **Bootstrap OS** (e.g. Ubuntu 24.04 from Terraform): `apt update && apt install -y haproxy keepalived` (optional, for VIP).
2. **Join Tailscale** on both HAProxy nodes (and ensure RKE2 nodes are on the same tailnet).
3. **Configure HAProxy** using `haproxy.cfg.example` — set RKE2 API backends to your server Tailnet hostnames or IPs (100.x).
4. **(Optional)** Configure **keepalived** for a shared virtual IP on rancher-net so clients use one address; otherwise use DNS round-robin or both HAProxy IPs.
5. **Enable and start**: `systemctl enable haproxy && systemctl start haproxy` (and keepalived if used).

## Backend choice (Tailnet vs rancher-net)

- **Tailnet**: Use RKE2 nodes’ Tailscale names (e.g. `rke2-server-01`) or 100.x IPs. Works even if RKE2 is in another DC or different cloud; all nodes must be on the same tailnet.
- **Rancher-net**: Use RKE2 nodes’ private IPs (e.g. 10.0.1.x) only if those nodes are also on rancher-net in the same project.

## Files

| File | Purpose |
|------|--------|
| `README.md` | This plan and architecture |
| `haproxy.cfg.example` | Example HAProxy config for 6443 + 80/443 with RKE2 backends |
| `keepalived.conf.example` | Optional keepalived for shared VIP on the HAProxy pair |

## Notes

- All nodes (HAProxy + RKE2) sit on **tailnet**; use tailnet for backend connectivity when possible.
- If you use a floating VIP with keepalived, put it on rancher-net (e.g. 10.0.1.20) and point DNS or clients to that IP for 6443/80/443.
