## zen Tyres - Atom Application
## OCI Core Infrastructure for Test

resource oci_core_vcn zen-vcn-nonprd-corenetwork {
  cidr_blocks                 = [
        "10.103.0.0/16",
  ]
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "zen-vcn-nonprd-corenetwork"
  dns_label                   = "atomtest"
}

resource oci_core_internet_gateway zen-igw-nonprd-corenetwork {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "zen-igw-nonprd-corenetwork"
  enabled                     = "true"
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}

resource oci_core_service_gateway zen-sgw-nonprd-corenetwork {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "zen-sgw-nonprd-corenetwork"
  #route_table_id             = <<Optional value>>
  services {
        service_id            = data.oci_core_services.mumbai_services.services[0].id
  }
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}

resource oci_core_nat_gateway zen-ngw-nonprd-corenetwork {
  block_traffic               = "false"
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "zen-ngw-nonprd-corenetwork"
  #public_ip_id               = <<Optional value>>
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}

resource oci_core_subnet zen-sn-corenetwork-testdb {
  cidr_block                  = "10.103.1.0/24"
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  dhcp_options_id             = oci_core_vcn.zen-vcn-nonprd-corenetwork.default_dhcp_options_id
  display_name                = "zen-sn-corenetwork-testdb"
  dns_label                   = "testdb"
  prohibit_internet_ingress   = "true"
  prohibit_public_ip_on_vnic  = "true"
  route_table_id              = oci_core_route_table.zen-sn-corenetwork-testdb-rt.id
  security_list_ids           = [
        oci_core_security_list.zen-sl-sn-corenetwork-testdb.id,
  ]
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}

locals {
  testdb_subnet_ocid          = oci_core_subnet.zen-sn-corenetwork-testdb.id
}

resource oci_core_subnet zen-sn-corenetwork-testapps {
  cidr_block                  = "10.103.2.0/24"
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  dhcp_options_id = oci_core_vcn.zen-vcn-nonprd-corenetwork.default_dhcp_options_id
  display_name                = "zen-sn-corenetwork-testapps"
  dns_label                   = "testapps"
  prohibit_internet_ingress   = "false"
  prohibit_public_ip_on_vnic  = "false"
  route_table_id              = oci_core_vcn.zen-vcn-nonprd-corenetwork.default_route_table_id
  security_list_ids           = [
        oci_core_vcn.zen-vcn-nonprd-corenetwork.default_security_list_id,
  ]
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}

locals {
  testapps_subnet_ocid          = oci_core_subnet.zen-sn-corenetwork-testapps.id
}

resource oci_core_default_dhcp_options default-dhcp-options-for-zen-vcn-nonprd-corenetwork {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "default-dhcp-options-for-zen-vcn-nonprd-corenetwork"
  manage_default_resource_id  = oci_core_vcn.zen-vcn-nonprd-corenetwork.default_dhcp_options_id
  options {
    custom_dns_servers        = [
    ]
    #search_domain_names      = <<Optional value>>
    server_type               = "VcnLocalPlusInternet"
    type                      = "DomainNameServer"
  }
  options {
    #custom_dns_servers       = <<Optional value>>
    search_domain_names       = [
      "atomptest.oraclevcn.com",
    ]
    #server_type              = <<Optional value>>
    type                      = "SearchDomain"
  }
}

resource oci_core_default_route_table default-route-table-for-zen-vcn-nonprd-corenetwork {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "default-route-table-for-zen-vcn-nonprd-corenetwork"
  manage_default_resource_id  = oci_core_vcn.zen-vcn-nonprd-corenetwork.default_route_table_id
  route_rules {
    description               = "Internet via Internet Gateway"
    destination               = "0.0.0.0/0"
    destination_type          = "CIDR_BLOCK"
    network_entity_id         = oci_core_internet_gateway.zen-igw-nonprd-corenetwork.id
  }
}

resource oci_core_route_table zen-sn-corenetwork-testdb-rt {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "zen-sn-corenetwork-testdb-rt"
  route_rules {
    description               = "Internet via NAT Gateway"
    destination               = "0.0.0.0/0"
    destination_type          = "CIDR_BLOCK"
    network_entity_id         = oci_core_nat_gateway.zen-ngw-nonprd-corenetwork.id
  }
  route_rules {
    description               = "Oracle Services"
    destination               = data.oci_core_services.mumbai_services.services[0].cidr_block
    destination_type          = "SERVICE_CIDR_BLOCK"
    network_entity_id         = oci_core_service_gateway.zen-sgw-nonprd-corenetwork.id
  }
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}

resource oci_core_default_security_list default-security-list-for-zen-vcn-nonprd-corenetwork {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name = "default-security-List-for-zen-vcn-nonprd-corenetwork"
  egress_security_rules {
    destination               = "0.0.0.0/0"
    destination_type          = "CIDR_BLOCK"
    protocol                  = "all"
    stateless                 = "false"
  }
  ingress_security_rules {
    protocol                  = "6"
    source                    = "0.0.0.0/0"
    source_type               = "CIDR_BLOCK"
    stateless                 = "false"
    tcp_options {
      max                     = "22"
      min                     = "22"
      #source_port_range      = <<Optional value>>
    }
  }
  ingress_security_rules {
    icmp_options {
      code                    = "4"
      type                    = "3"
    }
    protocol                  = "1"
    source                    = "0.0.0.0/0"
    source_type               = "CIDR_BLOCK"
    stateless                 = "false"
  }
  ingress_security_rules {
    icmp_options {
      code                    = "-1"
      type                    = "3"
    }
    protocol                  = "1"
    source                    = "10.102.0.0/16"
    source_type               = "CIDR_BLOCK"
    stateless                 = "false"
  }
  manage_default_resource_id  = oci_core_vcn.zen-vcn-nonprd-corenetwork.default_security_list_id
}

resource oci_core_security_list zen-sl-sn-corenetwork-testdb {
  compartment_id              = local.zen-comp-non-prod-corenetwork-id
  display_name                = "zen-sl-sn-corenetwork-testdb"
  egress_security_rules {
    destination               = "0.0.0.0/0"
    destination_type          = "CIDR_BLOCK"
    protocol                  = "all"
    stateless                 = "false"

  }
  ingress_security_rules {
    protocol                  = "6"
    source                    = "10.10.0.0/16"
    source_type               = "CIDR_BLOCK"
    stateless                 = "false"
    tcp_options {
      max                     = "22"
      min                     = "22"
      #source_port_range      = <<Optional value>>
    }
  }
  ingress_security_rules {
    icmp_options {
      code                    = "4"
      type                    = "3"
    }
    protocol                  = "1"
    source                    = "0.0.0.0/0"
    source_type               = "CIDR_BLOCK"
    stateless                 = "false"
  }
  ingress_security_rules {
    icmp_options {
      code                    = "-1"
      type                    = "3"
    }
    protocol                  = "1"
    source                    = "10.10.0.0/16"
    source_type               = "CIDR_BLOCK"
    stateless                 = "false"
  }
  vcn_id                      = oci_core_vcn.zen-vcn-nonprd-corenetwork.id
}




