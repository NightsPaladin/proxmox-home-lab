terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.46.5"
    }
    pihole = {
      source  = "ryanwholey/pihole"
      version = "0.2.0"
    }
  }
}
