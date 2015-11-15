#!/usr/bin/env bash

# Description:   utils for bash scripting
# Maintainer:    Xavier Bruhiere <xavier.bruhiere@gmail.com>

set -euo pipefail
[[ ${SHELL_TRACE:=""} ]] && set -x

# const (
  readonly BINTRAY_URL=https://dl.bintray.com
# )

log() {
  local TIME=`date +"%T"`
  printf "[ ${TIME} ] -----> $@\n"
  #FIXME [ -n "$LOGFILE" ] && printf "[ $TIME ] -----> $@\n" >> $LOGFILE
}

conclude() {
  local msg=${1:-"Done sir, happy hacking !"}
  if [ $(which yosay) ]; then
    yosay "${msg}"
  else
    log "${msg}"
  fi
}

function detect_architecture() {
  local os=$(uname | awk '{print tolower($0)}')
  if [ $(uname -m) == "x86_64" ]; then
    local hardware="amd64"
  else
    local hardware="386"
  fi
  printf "${os}_${hardware}"
}

# utility function to check whether a command can be executed by the shell
# see http://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script
# Stolen from https://github.com/zettio/weave/blob/master/weave
command_exists () {
  command -v $1 >/dev/null 2>&1
}

install_package() {
  local package=${1}
  case $OSTYPE in
    darwin*)
      brew install ${package}
      ;;
    linux-gnu*)
      sudo apt-get install -q -y ${package}
      ;;
  esac
}

check_package() {
  local package=$1
  #if [ ! $(which ${package}) ]; then
  if ! command_exists ${package}; then
    log "${package} not found locally, installing ..."
    install_package ${package}
  fi
}

install_package() {
  local author=$1
  local project=$2
  local version=$3
  local platform=$(detect_architecture)
  local bin_dir=${4:-"${project}.${version}.${platform}"}

  # Consul package is hosted at a slightly diferrent address
  [ "${project}" == "consul" ] || version="${project}_${version}"

  local package_url=${BINTRAY_URL}/${author}/${project}/${version}_${platform}.zip
  local package_zip=${version}_${platform}.zip

  check_package "wget"
  check_package "unzip"

  log "downloading ${project} version ${version} for ${platform}, by ${author}."
  # TODO Show only progress bar
  log "${package_url}"
  wget --quiet --timeout 10 ${package_url}

  log "unpacking binaries ${package_zip} to ${bin_dir} ..."
  unzip ${package_zip} -d ${bin_dir}
  rm ${package_zip}

  log "add $PWD/${bin_dir} to the path"
  export PATH=$PATH:$PWD/${bin_dir}
}

log "loaded $(basename $0)"
