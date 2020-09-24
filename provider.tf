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
  token = var.do_token
}