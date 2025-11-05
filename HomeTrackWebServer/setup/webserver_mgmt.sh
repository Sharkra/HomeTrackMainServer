#!/bin/bash
# Sourcing auxiliary methods
source "$( dirname -- "${BASH_SOURCE[0]}" )"/../../common/bash/helper_functions.sh

function setupVirtualEnv(){
    {
        installPackages python3.13-venv
        python3.13 -m venv ~/Dependencies/.webservervenv && \
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
    
    if setupVirtualEnv; then
        echo_green "Virtual env setup"
    else
        echo_red "Virtual env setup failed"
        return 1
    fi
    return 0
}

function setupWebDevDependencies(){
    {
        installPackages python3-pip && \
        pip install --upgrade pip && \
        pip3.13 install Flask Flask-SQLAlchemy && \
        return 0
    } ||
    {
        return 1
    }
}

function installDevTools(){
    {
        pip3.13 install flask-debugtoolbar && \
        pip3.13 install pytest pytest-cov && \
        pip3.13 install flask-socketio gevent && \
        return 0
    } || {
        return 1
    }
}

function installProjectExternalPackages(){
    ( 
        cd /tmp && \
        wget https://registry.npmjs.org/chart.js/-/chart.js-4.5.1.tgz && \
        wget https://github.com/socketio/socket.io/archive/refs/tags/socket.io@4.8.1.tar.gz && \
        mkdir -p ~/Programming/HomeTrackWebServer/application/external_packages && \
        mkdir -p ~/Programming/HomeTrackWebServer/application/external_packages/chart.js
        cd ~/Programming/HomeTrackWebServer/application/external_packages/chart.js && \
        tar -xf /tmp/chart.js-4.5.1.tgz && \
        cd .. && \
        tar -xf /tmp/socket.io-socket.io-4.8.1.tar.gz
        
    )
}