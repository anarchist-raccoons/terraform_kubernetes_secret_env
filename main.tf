provider "kubernetes" {
  load_config_file = false
  host = "${var.host}"
  username = "${var.username}"
  password = "${var.password}"
  client_certificate = "${var.client_certificate}"
  client_key = "${var.client_key}"
  cluster_ca_certificate = "${var.cluster_ca_certificate}"
}

resource "kubernetes_secret" "default" {
  metadata {
    name = "env-secrets"
  }
  data = "${data.external.json.result}"
}

# Use a ruby script to extract a json hash of environment variables
# From TF 0.12 this can be replaced with TF functionality
data "external" "json" {
  program = ["ruby", "map_from_env.rb"]
}
