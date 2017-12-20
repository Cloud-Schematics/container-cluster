resource "ibm_container_cluster" "kubecluster" {
  name         = "${var.cluster_name}-${random_id.name.hex}"
  datacenter   = "${var.datacenter}"
  org_guid     = "${data.ibm_org.org.id}"
  space_guid   = "${data.ibm_space.space.id}"
  account_guid = "${data.ibm_account.account.id}"
  machine_type = "${var.machine_type}"
  public_vlan_id = "${var.public_vlan_id}"
  private_vlan_id = "${var.private_vlan_id}"
  no_subnet    = true

  workers = "${var.workers[var.num_workers]}"
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = "${ibm_container_cluster.kubecluster.name}"
  org_guid        = "${data.ibm_org.org.id}"
  space_guid      = "${data.ibm_space.space.id}"
  account_guid    = "${data.ibm_account.account.id}"
}

variable "cluster_name" {
  default = "kubecluster"
  description = "The base name for the cluster."
}
variable "region" {
  default = "us-south"
  description = "The IBM Cloud region where you want to deploy your cluster."
}
variable "datacenter" {
  default = "dal12"
  description = "The data center for the cluster, You can get the list with by running bluemix cs locations."
}
variable "machine_type" {
  default = "u2c.2x4"
  description = "The CPU cores, memory, network, and speed. You can get a list for a given location by running bluemix cs machine-types <location>."
}
variable "isolation" {
  default = "public"
}
variable "private_vlan_id" {
  description = "The private VLAN for your account. You can run bx cs vlans <location>."
}
variable "public_vlan_id" {
  description = "The public VLAN for your account. You can run bx cs vlans <location>."
}
variable "subnet_id" {
  description = "The portable subnet to use for cluster. You can view a list of available subnets by running bx cs subnets."
}
