variable "ssh_fingerprint" {
  default = ""
}

variable "do_token" {
  default = ""
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

provider "digitalocean" {
  # Configuration options
  ssh_fingerprint = var.ssh_fingerprint
  token = var.do_token
}