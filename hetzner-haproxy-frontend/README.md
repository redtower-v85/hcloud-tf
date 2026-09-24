# Frontend HAProxy (Hetzner) — Terraform

Manages **skynet-haproxy-2**, the HAProxy that fronts the Rancher UI (`oks01.ci.octostar.com`):
TCP passthrough on 443 with `send-proxy-v2` to the Rancher nodes, plus an HTTP to HTTPS redirect on 80.

| | |
|---|---|
| Server ID | 123391534 |
| Location | hel1 (hel1-dc2) |
| Public IPv4 | 46.62.193.126 |
| rancher-net | 10.0.1.1 |
| Tailnet | 100.86.199.54 (DNS for oks01 points here) |

The server was created by hand and is adopted with `import` blocks in `servers.tf`.
`prevent_destroy` and `ignore_changes` guard against an accidental rebuild.

The RKE2 API HAProxy (skynet-haproxy-1) lives in `../hetzner-haproxy-single`.

## Usage

```bash
export TF_VAR_hcloud_token="<hetzner-api-token>"
tofu init
tofu plan    # expect "No changes" (already imported 2026-09-24)
```

Firewall: `haproxy-single-fw`, owned by `../hetzner-haproxy-single` (shared with haproxy-1).
