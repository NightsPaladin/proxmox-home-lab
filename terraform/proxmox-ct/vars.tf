variable "vztmpl_datastore" {
  type        = string
  default     = "local"
  description = "The datastore in Proxmox which provides Container Template storage. Default: local"
}

variable "snippets_datastore" {
  type        = string
  default     = "local"
  description = "The datastore in Proxmox which provides snippets storage. Default: local"
}

variable "ct_datastore" {
  type        = string
  default     = "local-lvm"
  description = "The datastore in Proxmox which provides Container disk storage. Default: local-lvm"
}

variable "cluster_node" {
  type        = string
  default     = "pve01"
  description = "The Proxmox cluster node to create the Container on. Default: pve01"
}

variable "ct_name" {
  type        = string
  default     = "test-vm"
  description = "The name to assign to the Container. Default: test-vm"
}

variable "ct_id" {
  type        = number
  default     = 0
  description = "Specify the ID to assign the Container. Default: auto-assign next available"
}

variable "ct_os" {
  type        = string
  default     = "debian"
  description = "Select which OS Image to download and use: Ubuntu or Debian. Default: Debian"
}

variable "ct_cpu_cores" {
  type        = number
  default     = 1
  description = "Number of CPU cores to assign to the Container. Default: 1"
}

variable "ct_memory" {
  type        = number
  default     = 512
  description = "Amount of memory (in MB) to assign to the Container. Default: 512MB"
}

variable "ct_disksize" {
  type        = number
  default     = 4
  description = "Size of the Disk (in GB) to create for the Container. Default: 4GB"
}

variable "ct_ip_address" {
  type        = string
  default     = "dhcp"
  description = "The IP Address to assign to the Container. Default: DHCP"
}

variable "ct_gateway" {
  type        = string
  description = "The default gateway to assign to the Container. No default value assigned"
}

variable "ct_dns_domain" {
  type        = string
  description = "The DNS Domain to configure in the Container. No default set."
}

variable "ct_dns_servers" {
  type        = list(string)
  description = "The DNS Servers to configure in the Container. No default set."
}

variable "ct_net_bridge" {
  type        = string
  default     = "vmbr0"
  description = "The network bridge to assign the Container to in Proxmox. Default: vmbr0"
}

variable "ct_firewall" {
  type        = bool
  default     = false
  description = "Enable or Disable the Firewall on the Container. Default: Disabled"
}

variable "ct_root_password" {
  type        = string
  description = "Sets the root user password. No default set."
}

variable "ct_ssh_keys" {
  type        = list(string)
  default     = []
  description = "Configure SSH Keys for the root account in the container. Default: Empty list"
}

variable "ct_nesting" {
  type        = bool
  default     = false
  description = "Allow container nesting. Default: False"
}

variable "ct_fuse" {
  type        = bool
  default     = false
  description = "Allow container to use FUSE to mount drives. Default: False"
}

variable "ct_add_dns_record" {
  type        = bool
  default     = false
  description = "Add a DNS record to Pihole for the Container. Default: No (False)"
}

variable "ct_cname_records" {
  type        = list(string)
  default     = []
  description = "A list of CNAMEs to assign to the Container's DNS record in Pihole. Default: Empty list (meaning no records)"
}
