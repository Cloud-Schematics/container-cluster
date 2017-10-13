provider "ibm" {
  bluemix_api_key = "${var.bluemix_api_key}"
  region = "${var.region}"
}

data "ibm_org" "org" {
  org = "${var.org}"
}

data "ibm_space" "space" {
  org   = "${var.org}"
  space = "${var.space}"
}

data "ibm_account" "account" {
  org_guid = "${data.ibm_org.org.id}"
}

resource "random_id" "name" {
  byte_length = 4
}

variable "bluemix_api_key" {
  description = "Your Bluemix API key. You can get the value by running bx iam api-key-create <key name>."
}
variable "org" {
  description = "Your Bluemix org GUID. You can get the value by running bx iam org <org name> --guid."
}
variable "space" {
  default = "dev"
  description = "Your Bluemix space GUID. You can get the value by running bx iam space <space name> --guid."
}

