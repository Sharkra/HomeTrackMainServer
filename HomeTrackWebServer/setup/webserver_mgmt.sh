#!/bin/bash
# Sourcing auxiliary methods
source "$( dirname -- "${BASH_SOURCE[0]}" )"/../../common/bash/helper_functions.sh

function setupVirtualEnv(){
    {
        installPackages python3.13-venv
        python -m venv ~/Dependencies/.webservervenv && \
        source ~/Dependencies/.webservervenv/bin/activate && \
        return 0
    } || {
        return 1
    }
}

function setupPython(){
    {
        addRepo ppa:deadsnakes/ppa
        sudo apt update
        installPackages python3.13
        echo "alias python='/usr/bin/python3.13'" >> ~/.bashrc
        source ~/.bashrc
        return 0
    } || {
        return 1
    }
}

function setupPythonEnv(){
    if setupPython; then
        echo_green "Python setup"
    else
        echo_red "Python setup failed"
        return 1
    fi
    return 0
    
    if setupVirtualEnv; then
        echo_green "Virtual env setup"
    else
        echo_red "Virtual env setup failed"
        return 1
    fi
    return 0
}
