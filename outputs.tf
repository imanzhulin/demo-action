output "droplet_ipv4" {
  value = [digitalocean_droplet.do-droplet.ipv4_address, digitalocean_droplet.do-droplet-2.ipv4_address]
}
