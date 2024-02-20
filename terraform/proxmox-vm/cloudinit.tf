data "template_file" "userdata" {
  template = file("${path.module}/templates/userdata.yml")

  vars = {
    vm_name = var.vm_name
  }
}

resource "random_id" "cloud_init" {
  keepers = {
    cloud_init_id = var.vm_name
  }
  byte_length = 8
}

resource "proxmox_virtual_environment_file" "vm_cloudinit_userconfig" {
  content_type = "snippets"
  datastore_id = var.snippets_datastore
  node_name    = var.cluster_node

  source_raw {
    data      = sensitive(data.template_file.userdata.rendered)
    file_name = "cloudinit-userconfig-${random_id.cloud_init.hex}-${random_id.cloud_init.keepers.cloud_init_id}.yml"
  }
}
