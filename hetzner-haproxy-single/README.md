# RKE2 HAProxy (Hetzner): OpenTofu

Manages **skynet-haproxy-1** (cx33, nbg1, `10.0.1.21`), the load balancer for the RKE2
Kubernetes API (6443) and supervisor/join port (9345), in front of the three Rancher nodes.

Also owns the firewall **`haproxy-single-fw`**, which is shared with skynet-haproxy-2
(`../hetzner-haproxy-frontend`). haproxy-2 is attached via `var.extra_firewall_server_ids`.

HAProxy's own config lives on the server in `/etc/haproxy/haproxy.cfg` (not managed here).

```bash
export TF_VAR_hcloud_token="<hetzner-api-token>"
tofu init && tofu plan
```
