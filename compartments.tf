## zen Hotels 
## OCI Compartments

/*
resource "oci_identity_compartment" "zen-comp-prod-corenetwork" {
  name                                  = "zen-comp-prod-corenetwork"
  description                           = "zen Production Core Network compartment"
  compartment_id                        = var.tenancy_ocid
  enable_delete                         = false             
}

resource "oci_identity_compartment" "zen-comp-prod" {
  name                                  = "zen-comp-prod"
  description                           = "zen Production compartment"
  compartment_id                        = var.tenancy_ocid
  enable_delete                         = false            
}

resource "oci_identity_compartment" "zen-comp-non-prod-corenetwork" {
  name                                  = "zen-comp-non-prod-corenetwork"
  description                           = "zen Non-Production Core Network compartment"
  compartment_id                        = var.tenancy_ocid
  enable_delete                         = false            
}

resource "oci_identity_compartment" "zen-comp-non-prod" {
  name                                  = "zen-comp-non-prod"
  description                           = "zen Non-Production compartment"
  compartment_id                        = var.tenancy_ocid
  enable_delete                         = false            
}
*/


data oci_identity_compartments zen-comp-prod-corenetwork {
    compartment_id  = var.tenancy_ocid
    filter {
        name   = "name"
        values = ["zen-comp-prod-corenetwork"]
    }
}

locals {
  zen-comp-prod-corenetwork-id = data.oci_identity_compartments.zen-comp-prod-corenetwork.compartments[0].id
} 

data oci_identity_compartments zen-comp-prod {
    compartment_id  = var.tenancy_ocid
    filter {
         name   = "name"
         values = ["zen-comp-prod"]
    }
}

locals {
  zen-comp-prod-id = data.oci_identity_compartments.zen-comp-prod.compartments[0].id
}

data oci_identity_compartments zen-comp-non-prod-corenetwork {
    compartment_id  = var.tenancy_ocid
    filter {
         name   = "name"
         values = ["zen-comp-non-prod-corenetwork"]
    }
}

locals {
  zen-comp-non-prod-corenetwork-id = data.oci_identity_compartments.zen-comp-non-prod-corenetwork.compartments[0].id
}

data oci_identity_compartments zen-comp-non-prod {
    compartment_id  = var.tenancy_ocid
    filter {
        name   = "name"
        values = ["zen-comp-non-prod"]
    }
}

locals {
  zen-comp-non-prod-id = data.oci_identity_compartments.zen-comp-non-prod.compartments[0].id
}

data oci_identity_compartments migration {
    compartment_id  = var.tenancy_ocid
    filter {
        name   = "name"
        values = ["migration"]
    }
}



