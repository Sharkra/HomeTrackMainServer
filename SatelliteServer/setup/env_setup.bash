#!/bin/bash

# Sourcing auxiliary methods
source "$( dirname -- "${BASH_SOURCE[0]}" )"/helper_functions.sh
source "$( dirname -- "${BASH_SOURCE[0]}" )"/database_mgmt.sh

# Start with a fresh Ubuntu install

echo_blue "Starting environment setup"

echo_blue "Installing Utility packages"
installPackages openssh-server
echo_green "Utility packages installed"

