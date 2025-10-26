#!/bin/bash

function dbCommand(){
    mysql -u"$user" -p"$password" -e "$1"
}

function listDBTables(){
    dbCommand "USE ${db_name}; \
               SHOW TABLES;"
}

function showDataInTable(){
    dbCommand "USE ${db_name}; \
               SELECT * FROM ${1};"
}