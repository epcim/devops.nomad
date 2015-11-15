#! /usr/bin/env bash

# description: download and install nomad (https://packer.io)
# maintainer:  Xavier Bruhiere (xavier.bruhiere@gmail.com)

# const (
  # magic variables
  readonly __PROGRAM__=$(basename $0)
# )

usage() {
  cat <<- EOF

  usage: ${__PROGRAM__} [project] [version] [bin_directory] <author>

  Download and install hashicorp binary (https://packer.io)

  Example:
    $ ./installer.sh packer 0.7.3 /usr/local/bin/packer

EOF
  exit 0
}

main() {
  # cli args
  local PROJECT=${1}
  local VERSION=${2}
  local BIN_DIR=${3}
  local AUTHOR=${4:-"mitchellh"}

  log "Packer installer."
  install_package "${AUTHOR}" "${PROJECT}" ${VERSION} ${BIN_DIR}

  conclude "done sir, happy ${PROJECT}ing!\n"
}

[ ${PROJECT} == "--help" -o ${PROJECT} == "-h" ] && usage
# TODO fail on bad/no args
source ./libinstall.bash
main $@

