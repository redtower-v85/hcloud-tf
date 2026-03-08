terraform {
  required_version = ">= 1.6.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.60"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

data "hcloud_ssh_key" "rancher_key" {
  name = "ranchertest01"
}

resource "hcloud_server" "rancher_nodes" {
  count = 4

  name        = format("rnch%02d", count.index + 1)
  server_type = "cx33"
  image       = "ubuntu-24.04"
  location    = "hel1"

  ssh_keys = [
    data.hcloud_ssh_key.rancher_key.id
  ]

  labels = {
    cluster = "rancher"
  }
}
