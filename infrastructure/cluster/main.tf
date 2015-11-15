variable "ssh_keys" {}
variable "servers_scale" {}
variable "clients_scale" {}
variable "region" {}
variable "nomad_artifact_id" {}

module "servers" {
  source     = "./server"
  image      = "${var.nomad_artifact_id}"
  region     = "${var.region}"
  scale      = "${var.servers_scale}"
  ssh_keys   = "${var.ssh_keys}"
}

module "clients" {
  source    = "./client"
  image     = "${var.nomad_artifact_id}"
  region    = "${var.region}"
  scale     = "${var.clients_scale}"
  servers   = "${module.servers.addrs}"
  ssh_keys  = "${var.ssh_keys}"
}

output "Nomad Servers" {
  value = "${join(" ", split(",", module.servers.addrs))}"
}

output "Nomad Clients" {
  value = "${join(" ", split(",", module.clients.addrs))}"
}
