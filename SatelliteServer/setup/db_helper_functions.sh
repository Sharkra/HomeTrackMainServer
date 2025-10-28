#!/bin/bash

function dbCommand(){
    mysql -u"$user" -p"$password" -e "$1"
}

function listDBTables(){
    dbCommand "USE ${db_name}; \
               SHOW TABLES;"
}

function listDBs(){
    dbCommand "SHOW DATABASES;"
}

function dropDB(){
    dbCommand "DROP DATABASE $1;"
}

function showDataInTable(){
    dbCommand "USE ${db_name}; \
               SELECT * FROM ${1};"
}