# Use SSH key that already provisioned
data "digitalocean_ssh_key" "example" {
  name = "do-ivan-host"
}

resource "digitalocean_droplet" "do-droplet" {
    image    = "docker-20-04"
    name     = "test-droplet"
    region   = "ams3"
    size     = "s-1vcpu-1gb"
    ssh_keys = [data.digitalocean_ssh_key.example.fingerprint]
    tags     = ["test"]
}

resource "digitalocean_project" "infra" {
  name        = "infra"
  description = "Infrastructure: Terraform, Ansible, GitHub Actions"
  purpose     = "Operational / Developer tooling"
  resources   = [digitalocean_droplet.do-droplet.urn]
}

resource "digitalocean_firewall" "do-droplet" {
  name = "allow-ssh-http-https"

  droplet_ids = [digitalocean_droplet.do-droplet.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}