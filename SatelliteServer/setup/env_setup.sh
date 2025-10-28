#!/bin/bash

# Sourcing auxiliary methods
source "$( dirname -- "${BASH_SOURCE[0]}" )"/../../common/bash/helper_functions.sh
source "$( dirname -- "${BASH_SOURCE[0]}" )"/database_mgmt.sh

set -e

# Start with a fresh Ubuntu install

echo_blue "Starting environment setup"

sudo apt update

echo_blue "Installing Utility packages"
installPackages openssh-server
echo_green "Utility packages installed"

echo_blue "Installing database packages"
installPackages mysql-server
echo_green "Database packages installed"

echo_blue "Setting up database"
setupMySQL
echo_green "Database set up"
