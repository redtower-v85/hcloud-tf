#cloud-config
# Install Tailscale and join tailnet with tag ssh-server; enable Tailscale SSH
runcmd:
  - curl -fsSL https://tailscale.com/install.sh | sh && tailscale up --authkey='${auth_key}' --ssh
