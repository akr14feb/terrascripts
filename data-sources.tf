## zen Tyres - Atom Application
## OCI Availability Domains

data oci_identity_tenancy tenancy {
  tenancy_id        = var.tenancy_ocid
}

# Tenancy's home region
data oci_identity_regions home_region {
  filter {
    name                = "key"
    values              = [data.oci_identity_tenancy.tenancy.home_region_key]
  }
}

locals {
    home_region         = data.oci_identity_regions.home_region.id
}

output my_homeregion {
  value                 = data.oci_identity_regions.home_region
}

data oci_identity_availability_domains ad_list {
  compartment_id        = var.tenancy_ocid
}

data template_file ad_names {
  count                 = length(data.oci_identity_availability_domains.ad_list.availability_domains)
  template              = lookup(data.oci_identity_availability_domains.ad_list.availability_domains[count.index], "name")
}

data oci_identity_fault_domains fd_list {
    compartment_id      = var.tenancy_ocid
    availability_domain = data.oci_identity_availability_domains.ad_list.availability_domains[0].name
}

data template_file fd_names {
  count                 = length(data.oci_identity_fault_domains.fd_list.fault_domains)
  template              = lookup(data.oci_identity_fault_domains.fd_list.fault_domains[count.index], "name")
}

data oci_objectstorage_namespace tenancy_namespace {
  compartment_id        = var.tenancy_ocid
}

output my_namespace {
  value                 = data.oci_objectstorage_namespace.tenancy_namespace
}

data oci_core_services mumbai_services {
  filter {
    name                = "cidr_block"
    #values             = ["^oci-[a-z]+-objectstorage"]
    values              = ["^all-[a-z]+-services-in-oracle-services-network"]
    regex               = true
  }
}

output my_services {
  value                 = data.oci_core_services.mumbai_services.services
}