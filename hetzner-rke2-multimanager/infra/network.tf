resource "hcloud_network" "rke2" {
  name     = var.network_name
  ip_range = var.network_cidr
}

resource "hcloud_network_subnet" "rke2_nodes" {
  network_id   = hcloud_network.rke2.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.subnet_cidr
}
