# Single HAProxy (Hetzner) — Terraform

Provisions **1 server** (cx33) in **Nuremberg (nbg1)** on the existing **rancher-net** network, no IPv6. Server uses the **ranchertest01** SSH key for access. For use as a single HAProxy in front of an RKE2 cluster; all nodes sit on Tailnet.

## Prerequisites

- **rancher-net** must already exist (e.g. from `hetzner-rancher-infra`). This module does **not** create the network; it looks it up by name.
- The private IP used for the HAProxy node (default `10.0.1.21`) must be free in the rancher-net subnet. Default node name: `skynet-haproxy-1`.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and set hcloud_token

terraform init
terraform plan
terraform apply
```

## Outputs

- `server_public_ipv4` — public IP for SSH.
- `server_private_ipv4` — private IP on rancher-net (10.0.1.21 by default).

## Next steps

See **../haproxy-pair-setup/** for example HAProxy config for RKE2 (6443, 80, 443) with Tailnet backends. No keepalived needed for a single node.
