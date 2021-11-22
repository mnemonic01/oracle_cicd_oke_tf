/*------------------------------------------------------------------------------
    PROVIDER
-------------------------------------------------------------------------------*/
provider "oci" {
  region           = "${var.region}"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
}


data "oci_identity_tenancy" "tenancy" {
  tenancy_id = "${var.tenancy_ocid}"
}

data "oci_identity_regions" "home-region" {
  filter {
    name   = "key"
    values = ["${data.oci_identity_tenancy.tenancy.home_region_key}"]
  }
}

provider "oci" {
  alias            = "home"
  region           = "${lookup(data.oci_identity_regions.home-region.regions[0], "name")}"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
}

/*------------------------------------------------------------------------------
    COMPARTMENT
------------------------------------------------------------------------------*/

resource "oci_identity_compartment" "Demo" { 
  provider       = oci.home
  compartment_id = "${lookup(data.oci_identity_compartments.qualogyholding.compartments[0],"id")}"
  description    = "${var.project_name}"
  name           = "${var.project_name}"
}

/*-------------------------------------------------------------------------------
    NETWORKING 
-------------------------------------------------------------------------------*/

resource "oci_core_virtual_network" "demo_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = "${oci_identity_compartment.Demo.id}"
  display_name   = "VcnForClusters"
}

resource "oci_core_internet_gateway" "demo_ig" {
  compartment_id = "${oci_identity_compartment.Demo.id}"
  display_name   = "ClusterInternetGateway"
  vcn_id         = "${oci_core_virtual_network.demo_vcn.id}"
}

resource "oci_core_route_table" "demo_route_table" {
  compartment_id = "${oci_identity_compartment.Demo.id}"
  vcn_id         = "${oci_core_virtual_network.demo_vcn.id}"
  display_name   = "ClustersRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.demo_ig.id}"
  }
}

/*--------------------------------------------------------------------------------
    MODULES
--------------------------------------------------------------------------------*/

module "k8s"{
  source           = "./k8s"

  ads              = [ "${local.ad_1_name}", "${local.ad_2_name}", "${local.ad_2_name}" ]
  compartment_ocid = "${oci_identity_compartment.Demo.id}"

  vcn              = "${oci_core_virtual_network.demo_vcn.id}"
  route_table_id   = "${oci_core_route_table.demo_route_table.id}"
  sec_lists_ids    = "${oci_core_virtual_network.demo_vcn.default_security_list_id}"
}

