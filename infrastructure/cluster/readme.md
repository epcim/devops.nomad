# Cluster

## Cluster up

_note: currently assuming you already registered an ssh key on your account._

TODO : describe how

```Bash
# configure digital ocean
export DIGITALOCEAN_TOKEN="..."

# configure ssh
# fetch ssh key id (see below)
# start ssh-agent
ssh-agent -s
# register ssh private key
ssh-add $HOME/.ssh/do_id_rsa

# edit variables
$EDITOR terraform.tfvars

# register 'server' and 'client' modules
terraform get
```

```Bash
# apply configuration
terraform apply
```


## Nomad

Assuming ssh keys were registered previously, simply read servers ip with
`terraform output` and ssh to it as root. Once there :

```Bash
# check everything is working properly
docker version
nomad agent-info
```

Or locally

```Bash
# replace with one server of `terraform output`
nomad node-status -address=http://1.2.3.4:4646
```

Anyway:

```Bash
nomad init
# edit example.nomad with your datacenter name (ex: lon1)
nomad run example.nomad
```


## Utils

__List of snapshots__

__TODO Describe how to use var.packer_artifact ids__

```Bash
curl -s "https://api.digitalocean.com/v2/images?private=true" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  | python -m json.tool
```

__Get ssh keys ids__

```Bash
curl -s "https://api.digitalocean.com/v2/account/keys" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  | python -m json.tool
```

