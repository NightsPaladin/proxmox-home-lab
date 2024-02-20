resource "proxmox_virtual_environment_download_file" "latest_debian_bookworm_img" {
  count        = var.vm_os == "debian" ? 1 : 0
  content_type = "iso"
  datastore_id = var.iso_datastore
  node_name    = var.cluster_node
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
  file_name    = "debian-12-genericcloud-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "latest_ubuntu_jammy_img" {
  count        = var.vm_os == "ubuntu" ? 1 : 0
  content_type = "iso"
  datastore_id = var.iso_datastore
  node_name    = var.cluster_node
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = var.cluster_node
  vm_id     = var.vm_id != 0 ? var.vm_id : null

  cpu {
    cores = var.vm_cpu_cores
  }

  memory {
    dedicated = var.vm_memory
  }

  dynamic "disk" {
    for_each = var.vm_os == "debian" ? [1] : []
    content {
      datastore_id = var.vm_datastore
      file_id      = proxmox_virtual_environment_download_file.latest_debian_bookworm_img[0].id
      interface    = "scsi0"
      discard      = "on"
      ssd          = true
      size         = var.vm_disksize
    }
  }

  dynamic "disk" {
    for_each = var.vm_os == "ubuntu" ? [1] : []
    content {
      datastore_id = var.vm_datastore
      file_id      = proxmox_virtual_environment_download_file.latest_ubuntu_jammy_img[0].id
      interface    = "scsi0"
      discard      = "on"
      ssd          = true
      size         = var.vm_disksize
    }
  }

  network_device {
    bridge = var.vm_net_bridge
  }

  vga {
    type = "std"
  }

  dynamic "agent" {
    for_each = var.vm_guest_agent ? [1] : []
    content {
      enabled = true
      trim    = true
    }
  }

  initialization {
    datastore_id = var.vm_datastore
    interface    = "ide2"
    dns {
      domain  = var.vm_dns_domain
      servers = var.vm_dns_servers
    }
    ip_config {
      ipv4 {
        address = var.vm_ip_address
        gateway = var.vm_gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.vm_cloudinit_userconfig.id
  }
}

resource "pihole_dns_record" "dns_record" {
  count  = var.vm_add_dns_record ? 1 : 0
  domain = "${var.vm_name}.${var.vm_dns_domain}"
  ip     = substr(var.vm_ip_address, 0, length(var.vm_ip_address) - 3)
}

resource "pihole_cname_record" "cname_records" {
  count  = length(var.vm_cname_records)
  target = pihole_dns_record.dns_record[0].domain
  domain = var.vm_cname_records[count.index]
}
