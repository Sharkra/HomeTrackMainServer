#!/bin/bash
source "$( dirname -- "${BASH_SOURCE[0]}" )"/helper_functions.sh

user="dbuser"
password="123" #Could be changed as to be a prompt in the future"
db_name="HomeTrackDB"


function createDBUser(){
    echo_blue "Creating DB user"
    
    if [ -f /root/.my.cnf ]; then
        mysql -e "CREATE DATABASE IF NOT EXISTS ${db_name};"
        mysql -e "CREATE USER IF NOT EXISTS ${user}@localhost IDENTIFIED BY '${password}';"
        mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${user}'@'localhost';"
        mysql -e "FLUSH PRIVILEGES;"
    else
        sudo mysql -e "CREATE DATABASE IF NOT EXISTS ${db_name} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
        sudo mysql -e "CREATE USER IF NOT EXISTS ${user}@localhost IDENTIFIED BY '${password}';"
        sudo mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${user}'@'localhost';"
        sudo mysql -e "FLUSH PRIVILEGES;"
    fi
}


function setupMySQL(){
    ensureServiceisRunning mysql

    createDBUser

    createDBSchema
}