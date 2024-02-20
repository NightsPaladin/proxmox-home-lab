module "debian-test-vm" {
  source = "./proxmox-vm"
  providers = {
    proxmox = proxmox
  }

  cluster_node   = "pve01"
  vm_os          = "debian"
  vm_name        = "debian-test-vm"
  vm_guest_agent = true

  iso_datastore      = "local"
  snippets_datastore = "local"
  vm_datastore       = "local-lvm"

  vm_cpu_cores = 2
  vm_memory    = 2048
  # vm_disksize  = "8G"

  vm_ip_address  = "192.168.1.254/24"
  vm_gateway     = "192.168.1.1"
  vm_dns_domain  = "homelab.net"
  vm_dns_servers = ["192.168.1.6"]
  vm_net_bridge  = "vmbr0"

  vm_add_dns_record = true
  # vm_cname_records   = ["test-vm.homelab.net", "just-a-test.homelab.net"]
}

module "ubuntu-test-vm" {
  source = "./proxmox-vm"
  providers = {
    proxmox = proxmox
  }

  cluster_node   = "pve01"
  vm_name        = "ubuntu-test-vm"
  vm_os          = "ubuntu"
  vm_guest_agent = true

  iso_datastore      = "local"
  snippets_datastore = "local"
  vm_datastore       = "local-lvm"

  vm_cpu_cores = 2
  vm_memory    = 2048
  # vm_disksize  = "8G"

  vm_ip_address  = "192.168.1.253/24"
  vm_gateway     = "192.168.1.1"
  vm_dns_domain  = "homelab.net"
  vm_dns_servers = ["192.168.1.6"]
  vm_net_bridge  = "vmbr0"

  vm_add_dns_record = true
  # vm_cname_records   = ["test-vm.homelab.net", "just-a-test.homelab.net"]
}

module "debian-test-ct" {
  source = "./proxmox-ct"
  providers = {
    proxmox = proxmox
  }

  ct_os            = "debian"
  ct_root_password = "test1234"

  vztmpl_datastore   = "local"
  snippets_datastore = "local"
  ct_datastore       = "local-lvm"

  cluster_node = "pve01"
  ct_name      = "test-ct-debian"
  # ct_id        = 100

  ct_cpu_cores = 2
  ct_memory    = 2048
  # ct_disksize  = "4G"

  ct_ip_address  = "192.168.1.252/24"
  ct_gateway     = "192.168.1.1"
  ct_dns_domain  = "homelab.net"
  ct_dns_servers = ["192.168.1.6"]
  ct_net_bridge  = "vmbr0"
  # ct_firewall    = true

  ct_add_dns_record = true
  # ct_cname_records   = ["test-vm.homelab.net", "just-a-test.homelab.net"]

  # ct_nesting = true
  # ct_fuse    = true
}

module "ubuntu-test-ct" {
  source = "./proxmox-ct"
  providers = {
    proxmox = proxmox
  }

  ct_os            = "ubuntu"
  ct_root_password = "test1234"

  vztmpl_datastore   = "local"
  snippets_datastore = "local"
  ct_datastore       = "local-lvm"

  cluster_node = "pve01"
  ct_name      = "test-ct-ubuntu"
  # ct_id        = 100

  ct_cpu_cores = 2
  ct_memory    = 2048
  # ct_disksize  = "4G"

  ct_ip_address  = "192.168.1.251/24"
  ct_gateway     = "192.168.1.1"
  ct_dns_domain  = "homelab.net"
  ct_dns_servers = ["192.168.1.6"]
  ct_net_bridge  = "vmbr0"
  # ct_firewall    = true

  ct_add_dns_record = true
  # ct_cname_records   = ["test-vm.homelab.net", "just-a-test.homelab.net"]

  # ct_nesting = true
  # ct_fuse    = true
}
