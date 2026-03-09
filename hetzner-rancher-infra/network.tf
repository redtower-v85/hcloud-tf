resource "hcloud_network" "rancher" {
  name     = var.network_name
  ip_range = var.network_cidr
}

resource "hcloud_network_subnet" "rancher_nodes" {
  network_id   = hcloud_network.rancher.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.subnet_cidr
}
