terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
// digital ocean access token
variable "do_token" {
  type = string
  sensitive = true
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Ghost Droplet
resource "digitalocean_droplet" "ghost" {
  name   = "ghost"
  size   = "s-1vcpu-1gb"
  image  = "ghost-20-04"
  region = "nyc3"
  ssh_keys = ["4e:f4:27:68:f3:f6:c2:8a:37:ec:d8:e6:9a:37:54:b1"]
}

resource "digitalocean_project" "crismar_me" {
  name        = "crismar.me"
  resources   = [digitalocean_droplet.ghost.urn]
}
