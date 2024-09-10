provider "kubernetes" {
#  load_config_file = false
  host = var.host
  username = var.username
  password = var.password
  client_certificate = var.client_certificate
  client_key = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}

resource "kubernetes_secret" "default" {
  metadata {
    name = "env-secrets"
  }
  data = data.external.env
}

# Run the script to get the environment variables of interest.
# This is a data source, so it will run at plan time.
data "external" "env" {
  program = ["${path.module}/env.sh"]
}
