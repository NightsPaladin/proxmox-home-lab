## Proxmox Home Lab using Ceph Shared Storage

This project comes with no warranty, support, or guarantees. It's a personal project for use in my own home lab that I'm sharing, but may not work for everyone, everywhere.

My home lab consists of 3 mini PCs serving as Proxmox hosts with single 2.5Gb NICs running at 1Gb speeds (Switch). Each system has a single 512GB SSD. I was looking for a method to run Ceph without needing a separate drive or network.

Ceph officially recommends that you have a separate NIC and network segment for it's traffic as it can saturate even a 10Gb network easily if there are too many nodes.

#### Initial Proxmox Cluster Setup

- Install bare hardware with Proxmox

  - Set maxvz option to 0 when selecting the disk to install to, so no local-lvm storage is created and the free space on the LVM volume is retained

- Create a cluster out of hosts after installing, this is most easily done via the Web UI

- Under Datacenter -> [Node] -> Updates -> Repositories, add the APT repository for "no-subscription"
  Disable the "enterprise" repo in the process from the same area

#### Manual Configuration of Ceph

Once the Cluster is configured you can manually configure Ceph using the following steps:

- Under Datacenter -> [Node] -> Ceph, install the Ceph packages, this needs to be done on each node in the cluster that will be providing Ceph storage.

- Perform initial setup including the Monitor and Manager (these only need be configured on the first node, but can be configured on additional nodes)

- Under Datacenter -> [Node] -> Ceph -> OSD, create the OSD on each node in the cluster

- Under -> Ceph -> Pools, create a Ceph Pool for storing VM and Container Disks

- Under Datacenter -> Storage, add the Ceph Pool as a storage option using the "RBD" type

- If using CephFS (required if you want to store Container templates, ISO Images, Snippets, Backups, etc.)

  - Create Metadata Servers under [Node] -> Ceph -> CephFS
  - Create a CephFS under [Node] -> Ceph -> CephFS (there is a default option which automatically adds this to Proxmox's Datacenter -> Storage area)

#### Automated Configuration of Ceph

- Clone this git repo to a system you can run Ansible from:

  `git clone https://github.com/nightspaladin/proxmox-home-lab`

- Edit the inventory substituting the hostname and IPs of your Proxmox cluster hosts

- Edit the variable files in `playbooks/vars/main.yml` and `playbooks/vars/vault.yml`to suit your needs. The latter should be encrypted with Ansible Vault, to keep things private.

- Run `ansible-playbook playbooks/proxmox-setup.yml -k --ask-vault-pass`

- This will:

  - Update all the packages on each node
  - Install sudo
  - Configure passwordless SSH access for root
  - Create an `ansible` user account with passwordless SSH access and passwordless sudo access
  - Create a Proxmox API user for Terraform and appropriate Role, so you can use the Telmate Proxmox provider to create VMs and Containers
    ([Telmate Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs))
  - Install and configure Ceph
  - And upload a Custom SSL Cert and Key to each node (example Cert/Keys are included, replace with your own. File names must match inventory names.)

#### Ceph Object Storage Gateway (S3-compatible storage)

There is an additional playbook which configures Ceph's Object Storage Gateway to serve an AWS S3-like interface. This will allow you to use Terraform's S3 backend to store state remotely without having to go off-premesis, when using the Telmate provider.

`ansible-playbook playbooks/proxmox-ceph-s3-setup.yml`

In order to create buckets you will need to have a DNS server that accepts a wildcard for whatever domain you choose in the vars (`proxmox_s3_hosts`). e.g. `*.s3.mylocalnetwork.local`

---

Copyright 2024 nightspaladin[AT]protonmail.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
“Software”), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
