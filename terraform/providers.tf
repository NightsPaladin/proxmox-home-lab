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

variable "pm_api_url" {
  type        = string
  description = "URL for Proxmox Cluster"
}

variable "pm_api_user" {
  type        = string
  description = "Username to use with Proxmox"
}

provider "proxmox" {
  endpoint = var.pm_api_url
  username = var.pm_api_user
  insecure = true

  ssh {
    agent = true
  }
}

variable "pihole_url" {
  type        = string
  description = "URL to Pihole (does not need include /admin)"
}
variable "pihole_password" {
  type        = string
  description = "Pihole Admin Password"
}

provider "pihole" {
  url      = var.pihole_url      # PIHOLE_URL
  password = var.pihole_password # PIHOLE_PASSWORD
}
