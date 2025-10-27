#!/bin/bash

function echo_green() { echo -e "\033[1;32m$1\033[0m"; }
function echo_red() { echo -e "\033[1;31m$1\033[0m"; }
function echo_blue() { echo -e "\033[1;34m$1\033[0m"; }

function checkPackagesInstalled() {
  if dpkg -s "$@" > /dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

function checkRepoExists() {
  if ls /etc/apt/sources.list.d | grep -q ".*${1}.*"; then
    return 0
  else
    return 1
  fi
}

function exportToBashrc() {
    if grep -F -q -x "$@" $HOME/.bashrc; then
        echo_green "Path already in bash. Not echoing it in."
    else
        echo_red "Path not in bash. Echo it into bashrc."
        echo "$@" >> $HOME/.bashrc
    fi
    source $HOME/.bashrc
}

function installPackages() {
  if checkPackagesInstalled "$@"; then
    echo_green "Package(s) Installed"
  else
    echo_blue "Installing \"$@\""
    sudo apt install -y "$@"
  fi
}

function installDebPackage(){

  if checkPackagesInstalled "$1"; then
    echo_green "Package Installed"
  else
    echo_blue "Downloading $1"
    cd /tmp
    wget "$2" -O "$1".deb
    echo_blue "Installing $1"
    sudo dpkg -i "$1".deb
    sudo apt install -f
  fi
}

function ensureServiceisRunning() {
  if checkServiceisRunning "$1"; then
    echo_green "$1 service already running"
    return 0
  else
    sudo systemctl start "$1".service
    if checkServiceisRunning "$1"; then
      echo_green "$1 service already running"
      return 0
    else
      echo_red "Failed to start service $1"
      return 1
    fi
  fi
}

function checkServiceisRunning() {
  if
    systemctl --type=service --state=running list-units | grep -q "$1"; then
    return 0
  else
    return 1
  fi
}