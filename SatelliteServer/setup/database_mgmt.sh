#!/bin/bash
source "$( dirname -- "${BASH_SOURCE[0]}" )"/helper_functions.sh

function createDBUser(){
    echo_blue "Creating DB user"
}

function createDBSchema(){
    echo_blue "Creating DB Schema"
}


function setupMySQL(){
    ensureServiceisRunning mysql

    createDBUser

    createDBSchema
}