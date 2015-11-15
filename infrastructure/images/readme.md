# Nomad Machine Image

[Nomad][nomad] droplet on [Digital Ocean][do], packaged by [Packer][packer].
The image can be used as a Nomad server or client, and have [Docker][docker]
installed for container-centric continuous deployment.

## Install

Download and install [Packer][packer].

```Bash
../../scripts/install.binary.sh packer 0.8.6 /usr/local/bin
# or cd ../.. && make tools
```

## Usage

Setup environment.

```Bash
export DIGITALOCEAN_TOKEN="..."
```

Build and upload image.

```Bash
cd nomad
packer validate packer.json
packer build packer.json
```


[packer]: https://packer.io/
[nomad]: https://www.nomadproject.io/
[do]: https://www.digitalocean.com/
[docker]: https://www.docker.com/
