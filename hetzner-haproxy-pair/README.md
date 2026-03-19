# HAProxy pair (Hetzner) — Terraform

Provisions **2 servers** (cx33) in **Nuremberg (nbg1)** on the existing **rancher-net** network, no IPv6. Servers use the **ranchertest01** SSH key for access. For use as an HAProxy pair in front of an RKE2 cluster; all nodes sit on Tailnet.

## Prerequisites

- **rancher-net** must already exist (e.g. from `hetzner-rancher-infra`). This module does **not** create the network; it looks it up by name.
- Private IPs used for the HAProxy nodes (default `10.0.1.21`, `10.0.1.22`) must be free in the rancher-net subnet. Default node names: `skynet-haproxy-1`, `skynet-haproxy-2`.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and set hcloud_token

terraform init
terraform plan
terraform apply
```

## Outputs

- `server_public_ipv4` — public IPs for SSH.
- `server_private_ipv4` — private IPs on rancher-net (10.0.1.21, 10.0.1.22 by default).

## Next steps

See **../haproxy-pair-setup/** for the operational plan and example HAProxy/keepalived config for RKE2, with Tailnet backends.
