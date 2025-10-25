#!/bin/bash


source helper_functions.sh

# Start with a fresh Ubuntu install

echo_blue "Starting environment setup"

echo_blue "Installing Utility packages"
installPackages openssh-server
echo_green "Utility packages installed"

