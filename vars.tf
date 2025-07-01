## zen Tyres - Atom Application
## Terraform Variables

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

#variable base_compartment_ocid { default = var.tenancy_ocid }
variable zen-comp-prod-corenetwork-id { default = "ocid1.compartment.oc1..aaaaaaaaj53gp7tavr3ojylfkqiwdjejcnfii5a5orpsiptfszcqkagzwmmq"}
variable zen-comp-prod-id { default = "ocid1.compartment.oc1..aaaaaaaafkuqt2yga3o34pfpxevub67bbhs4vplsoz5cjmotflgliqlby75q"}
variable zen-comp-non-prod-corenetwork-id { default = "ocid1.compartment.oc1..aaaaaaaappavylayeqnmqpee3uyle5ijolac5owu6iuegqhjqbkcqg6g6rdq"}
variable zen-comp-non-prod-id { default = "ocid1.compartment.oc1..aaaaaaaafd7xmyq33gii4astc72c6uk3qd4ymp6o22x7wee3zmfj5xc6a4la"}


