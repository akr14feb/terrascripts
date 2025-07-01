variable "compute_shape" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "compute_cpus" {
  type    = string
  default = "1"
}

variable "compute_memory_in_gbs" {
  type    = string
  default = "1"
}

variable "compute_image" {
  type    = string
  default = "Oracle-Linux-7.9-aarch64-2022.10.04-0-OKE-1.24.1-491"
}



variable "compute_ssh_authorized_keys" { 
     type = string 
     default = "oci_pub_api_key.pub"
}


resource "oci_core_instance" "tf_compute" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ad_list.availability_domains[0].name
  compartment_id      = local.zen-comp-non-prod-id
  shape               = var.compute_shape

source_details {
source_type = "image"
source_id = var.compute_image
}

  # Optional
  display_name        = "oraclebsapps1"

  shape_config {
    ocpus         = var.compute_cpus
    memory_in_gbs = var.compute_memory_in_gbs
  }

  create_vnic_details {
    subnet_id         = local.testapps_subnet_ocid
    assign_public_ip  = true
  }


 metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
  }


  preserve_boot_volume = false
}


# Outputs
output "compute_id" {
  value = oci_core_instance.tf_compute.id
}

output "db_state" {
  value = oci_core_instance.tf_compute.state
}

output "compute_public_ip" {
  value = oci_core_instance.tf_compute.public_ip
}
