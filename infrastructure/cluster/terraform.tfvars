# This is a comma-separated list of SSH key ID's or fingerprints
# available in your DigitalOcean account. These keys will be granted
# SSH access to all of the deployed instances.
# NOTE waiting for https://github.com/hashicorp/terraform/pull/3633 to use fingerprints
ssh_keys = "..."

# Main image built by packer
nomad_artifact_id = "..."

# nodes region
region = "lon1"

# nodes count
servers_scale = 2
clients_scale = 3
