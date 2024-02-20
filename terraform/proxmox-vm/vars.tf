variable "iso_datastore" {
  type        = string
  default     = "local"
  description = "The datastore in Proxmox which provides ISO/Image storage. Default: local"
}

variable "snippets_datastore" {
  type        = string
  default     = "local"
  description = "The datastore in Proxmox which provides snippets storage. Default: local"
}

variable "vm_datastore" {
  type        = string
  default     = "local-lvm"
  description = "The datastore in Proxmox which provides VM disk storage. Default: local-lvm"
}

variable "cluster_node" {
  type        = string
  default     = "pve01"
  description = "The Proxmox cluster node to create the VM on. Default: pve01"
}

variable "vm_name" {
  type        = string
  default     = "test-vm"
  description = "The name to assign to the VM. Default: test-vm"
}

variable "vm_id" {
  type        = number
  default     = 0
  description = "Specify the ID to assign the VM. Default: auto-assign next available"
}

variable "vm_os" {
  type        = string
  default     = "debian"
  description = "Select which OS Image to download and use: Ubuntu or Debian. Default: Debian"
}

variable "vm_cpu_cores" {
  type        = number
  default     = 1
  description = "Number of CPU cores to assign to the VM. Default: 1"
}

variable "vm_memory" {
  type        = number
  default     = 512
  description = "Amount of memory (in MB) to assign to the VM. Default: 512MB"
}

variable "vm_disksize" {
  type        = number
  default     = 8
  description = "Set the disk size (in GB) of the VM. Default: 8GB"
}

variable "vm_ip_address" {
  type        = string
  default     = "dhcp"
  description = "The IP Address to assign to the VM. Default: DHCP"
}

variable "vm_gateway" {
  type        = string
  description = "The default gateway to assign to the VM. No default value assigned"
}

variable "vm_dns_domain" {
  type        = string
  description = "The DNS Domain to configure in the VM. No default set."
}

variable "vm_dns_servers" {
  type        = list(string)
  description = "The DNS Servers to configure in the VM. No default set."
}

variable "vm_net_bridge" {
  type        = string
  default     = "vmbr0"
  description = "The network bridge to assign the VM to in Proxmox. Default: vmbr0"
}

variable "vm_guest_agent" {
  type        = bool
  default     = false
  description = "Enable the VM Guest Agent (must be pre-installed in the image or installed by cloud-init). Default: false"
}

variable "vm_add_dns_record" {
  type        = bool
  default     = false
  description = "Add a DNS record to Pihole for the VM. Default: no"
}

variable "vm_cname_records" {
  type        = list(string)
  default     = []
  description = "A list of CNAMEs to assign to the VM's DNS record in Pihole. Default: Empty list (meaning no records)"
}
