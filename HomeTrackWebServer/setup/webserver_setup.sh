#!/bin/bash

# Sourcing auxiliary methods
source "$( dirname -- "${BASH_SOURCE[0]}" )"/../../common/bash/helper_functions.sh
source "$( dirname -- "${BASH_SOURCE[0]}" )"/webserver_mgmt.sh

echo_blue "Installing Python environment"
if setupPythonEnv; then
    echo_green "Python environment installed"
else
    echo_red "Python environment installation failed"
fi

echo_blue "Installing WebDev dependencies"
if setupWebDevDependencies; then
    echo_green "WebDev dependencies installed"
else
    echo_red "WebDev dependencies installation failed"
fi

