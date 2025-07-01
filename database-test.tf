## zen Tyres - Atom Application
## OCI Database for Test

/*
resource oci_database_db_system atomtestdb {
  availability_domain = data.oci_identity_availability_domains.ad_list.availability_domains[0].name
  compartment_id             = local.zen-comp-non-prod-id
  cpu_core_count            = "1"
  data_storage_percentage   = "80"
  data_storage_size_in_gb   = "256"
  database_edition          = "ENTERPRISE_EDITION_HIGH_PERFORMANCE"
  db_home {
    database {
      admin_password = "oraCA##1c2O8le_4B"
      #backup_id = <<Optional value not found in discovery>>
      #backup_tde_password = <<Optional value not found in discovery>>
      character_set         = "AL32UTF8"
      db_backup_config {
        auto_backup_enabled = "false"
        auto_backup_window  = ""
      }
      db_name               = "zentest"
      db_workload           = "OLTP"
      ncharacter_set        = "AL16UTF16"
      pdb_name              = "PDB1"
      tde_wallet_password   = "oraCA##1c2O8le_4B"
    }
    db_version              = "19.17.0.0"
    display_name            = "dbhome1917"
  }
  db_system_options {
    storage_management      = "ASM"
  }

  disk_redundancy           = "HIGH"
  display_name              = "zentestdb"
  domain                    = "testdb.atomtest.oraclevcn.com"
  fault_domains             = [
        "FAULT-DOMAIN-3",
  ]
  hostname                  = "zentestdb"
  license_model             = "LICENSE_INCLUDED"
  node_count                = "1"
  private_ip                = "10.103.1.10"
  shape                     = "VM.Standard2.1"
  source                    = "NONE"
  ssh_public_keys           = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAq/DJGXxZm0cOSFcOZxgcpT6oZp7hbQUssBZnlqnFW+HcXZ6nyUKtHubq9zTSFAF9PHhSVI2+1c3wyRXEsCpEfUzR1bDsc4P4xyl0Y4edrQZg+0hNDKkGhPR0OPUnByTHIR6VTG/Zj+FuM0cJVBRknB0nbkdyhxlLX8XwKCQReSlbC2NijHExVjicF/XXd+97q4Tkdo46n3r0VQPCNCT3YyoHHiYu07c4TYhrckPal2yOVCuTkTyygV5/8nOgrxf+uKn8/+twl0ZUCg6yYjcbaembS0IDWB7L81LQAnrKgZ7/vJ5EJXFQxddfETEzAk904wWt5MSCERCRTV0H56CdhQ== rsa-key-20210412",
  ]
  subnet_id                 = local.testdb_subnet_ocid
  time_zone = "UTC"

  lifecycle {
    ignore_changes           = [db_home[0].database[0].admin_password,
                                db_home[0].database[0].tde_wallet_password,
                                ssh_public_keys]
  }
}
*/


