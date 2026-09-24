# hcloud-tf

OpenTofu for the **skynet Rancher** installation on Hetzner Cloud: `oks01.ci.octostar.com`.

```
                 tailnet only (no public exposure)
  users / downstream cluster agents
        │ https://oks01.ci.octostar.com  (DNS → 100.86.199.54, tailnet)
        ▼
  skynet-haproxy-2 (hel1)  ── TCP 443 passthrough, send-proxy-v2 ──┐
                                                                    ▼
  kubectl / RKE2 joins                                  skynet-rancher-01/02/03 (nbg1)
        │ 6443 / 9345                                   RKE2 control-plane + etcd,
        ▼                                               ingress-nginx → Rancher
  skynet-haproxy-1 (nbg1)  ── TCP 6443 / 9345 ─────────────────────┘
                     all on rancher-net 10.0.0.0/16 (subnet 10.0.1.0/24)
```

| Folder | Manages |
|---|---|
| `hetzner-rancher-infra/` | rancher-net network + subnet, the 3 Rancher nodes, `rancher-fw` |
| `hetzner-haproxy-single/` | skynet-haproxy-1 (RKE2 API / supervisor LB) and the shared `haproxy-single-fw` |
| `hetzner-haproxy-frontend/` | skynet-haproxy-2 (Rancher UI LB) |
| `hetzner-rancher-infra/k8s/` | In-cluster config (ingress-nginx `HelmChartConfig`) |

| Server | Hetzner ID | rancher-net | Tailnet |
|---|---|---|---|
| skynet-rancher-01 | 123421703 | 10.0.1.4 | 100.106.95.56 |
| skynet-rancher-02 | 123421704 | 10.0.1.2 | 100.64.32.126 |
| skynet-rancher-03 | 123421705 | 10.0.1.3 | 100.103.218.52 |
| skynet-haproxy-1 | 123328219 | 10.0.1.21 | 100.119.20.67 |
| skynet-haproxy-2 | 123391534 | 10.0.1.1 | 100.86.199.54 |

All servers were adopted into state with `import` blocks and carry `prevent_destroy`,
so Terraform will refuse to delete or rebuild them.

## Usage

The Hetzner API token is never stored in the repo:

```bash
export TF_VAR_hcloud_token="<hetzner-api-token>"
cd hetzner-rancher-infra        # or either haproxy folder
tofu init
tofu plan                       # expect "No changes" unless you edited something
```

State is local (`terraform.tfstate` in each folder) and committed to git; there is no remote backend.

## Access

- SSH: `ssh -i ~/.ssh/id_ranchertest root@<tailnet-ip>` (public SSH is firewalled off).
- kubectl on a Rancher node: `KUBECONFIG=/etc/rancher/rke2/rke2.yaml /var/lib/rancher/rke2/bin/kubectl ...`

## Firewall rules to know about

- Both firewalls are **tailnet-only**: UDP 41641 (Tailscale), ICMP, and everything from rancher-net.
  Do not add "any port from 0.0.0.0/0" rules in the Hetzner console.
- `rancher-fw` must keep **UDP 8472 from the nodes' public IPs**: flannel's VXLAN runs over
  the public addresses. Without it, cross-node pod traffic and the Rancher UI break.
- Hetzner firewalls do not filter rancher-net traffic, so HAProxy to node traffic is unaffected.
