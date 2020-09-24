#data "digitalocean_ssh_key" "example" {
  #name = "do-ivan-host"
#}

# Create a new SSH key
resource "digitalocean_ssh_key" "example" {
  name       = "tf-gh-action"
  public_key = file(".ssh/tf.pub")
}

resource "digitalocean_droplet" "do-droplet" {
    image    = "docker-20-04"
    name     = "test-droplet"
    region   = "ams3"
    size     = "s-1vcpu-1gb"
    ssh_keys = [digitalocean_ssh_key.example.fingerprint]
    tags     = ["test"]
}

resource "digitalocean_project" "infra" {
  name        = "infra"
  description = "Infrastructure: Terraform, Ansible, GitHub Actions"
  purpose     = "Operational / Developer tooling"
  resources   = [digitalocean_droplet.do-droplet.urn]
}
