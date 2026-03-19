provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_ssh_key" "rancher_key" {
  name = var.ssh_key_name
}
