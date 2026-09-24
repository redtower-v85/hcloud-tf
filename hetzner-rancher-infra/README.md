# Rancher nodes (Hetzner): OpenTofu

Manages the **rancher-net** network (`10.0.0.0/16`, subnet `10.0.1.0/24`), the three
RKE2/Rancher server nodes `skynet-rancher-01..03` (cpx42, nbg1) and their firewall `rancher-fw`.

The nodes were built by hand and adopted with the `import` blocks in `servers.tf`
(Hetzner IDs are in `var.servers`). `prevent_destroy` and `ignore_changes` stop
Terraform from ever recreating them.

Node OS and RKE2 setup is **not** managed here; see `/etc/rancher/rke2/config.yaml` on each node.
Rancher-01 bootstraps the cluster; 02 and 03 join via `https://10.0.1.21:9345` (skynet-haproxy-1).

`k8s/rke2-ingress-nginx-config.yaml` holds the ingress-nginx settings (PROXY protocol from
HAProxy). Apply it with kubectl on a server node; see the comments in the file.

```bash
export TF_VAR_hcloud_token="<hetzner-api-token>"
tofu init && tofu plan
```
