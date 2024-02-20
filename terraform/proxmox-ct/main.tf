resource "proxmox_virtual_environment_download_file" "latest_debian_bookworm_img" {
  count        = var.ct_os == "debian" ? 1 : 0
  content_type = "vztmpl"
  datastore_id = var.vztmpl_datastore
  node_name    = var.cluster_node
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
  overwrite    = true
}

resource "proxmox_virtual_environment_download_file" "latest_ubuntu_jammy_img" {
  count        = var.ct_os == "ubuntu" ? 1 : 0
  content_type = "vztmpl"
  datastore_id = var.vztmpl_datastore
  node_name    = var.cluster_node
  url          = "http://download.proxmox.com/images/system/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  overwrite    = true
}

resource "proxmox_virtual_environment_container" "container" {
  node_name = var.cluster_node
  vm_id     = var.ct_id != 0 ? var.ct_id : null

  dynamic "operating_system" {
    for_each = var.ct_os == "debian" ? [1] : []
    content {
      template_file_id = proxmox_virtual_environment_download_file.latest_debian_bookworm_img[0].id
      type             = "debian"
    }
  }

  dynamic "operating_system" {
    for_each = var.ct_os == "ubuntu" ? [1] : []
    content {
      template_file_id = proxmox_virtual_environment_download_file.latest_ubuntu_jammy_img[0].id
      type             = "ubuntu"
    }
  }

  cpu {
    cores = var.ct_cpu_cores
  }

  memory {
    dedicated = var.ct_memory
  }

  disk {
    datastore_id = var.ct_datastore
    size         = var.ct_disksize
  }

  network_interface {
    name     = "eth0"
    bridge   = var.ct_net_bridge
    firewall = var.ct_firewall
  }

  initialization {
    dns {
      domain  = var.ct_dns_domain
      servers = var.ct_dns_servers
    }
    ip_config {
      ipv4 {
        address = var.ct_ip_address
        gateway = var.ct_gateway
      }
    }

    hostname = var.ct_name

    user_account {
      keys     = var.ct_ssh_keys
      password = var.ct_root_password
    }
  }

  unprivileged = true

  features {
    nesting = var.ct_nesting
    fuse    = var.ct_fuse
  }
}

resource "pihole_dns_record" "dns_record" {
  count  = var.ct_add_dns_record ? 1 : 0
  domain = "${var.ct_name}.${var.ct_dns_domain}"
  ip     = substr(var.ct_ip_address, 0, length(var.ct_ip_address) - 3)
}

resource "pihole_cname_record" "cname_records" {
  count  = length(var.ct_cname_records)
  target = pihole_dns_record.dns_record[0].domain
  domain = var.ct_cname_records[count.index]
}
