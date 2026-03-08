# hcloud-tf

Terraform for Hetzner Cloud (hcloud) infrastructure: RKE2 single-manager and multi-manager stacks.

## Hetzner API token

The `hcloud_token` is not stored in `terraform.tfvars`. Set it via environment variables before running Terraform:

```bash
export HCLOUD_TOKEN="your-hetzner-api-token"
export TF_VAR_hcloud_token="$HCLOUD_TOKEN"
```

Then run `terraform plan` or `terraform apply` as usual. Terraform reads `TF_VAR_hcloud_token` and passes it to the `hcloud_token` variable.

Alternatively, pass it on the command line:

```bash
terraform plan -var "hcloud_token=$HCLOUD_TOKEN"
```

## Stacks

- **hetzner-rke2-singlemanager** – one manager node (controlplane + etcd), workers in `infra/`.
- **hetzner-rke2-multimanager** – multiple manager nodes, workers in `infra/`.

From this directory:

```bash
# Single-manager
cd hetzner-rke2-singlemanager/infra
terraform init && terraform plan

# Multi-manager
cd hetzner-rke2-multimanager/infra
terraform init && terraform plan
```

Ensure `HCLOUD_TOKEN` and `TF_VAR_hcloud_token` are set in your shell before running Terraform in either stack.
