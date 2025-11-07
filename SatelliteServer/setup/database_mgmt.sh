#!/bin/bash
source "$( dirname -- "${BASH_SOURCE[0]}" )"/../../common/bash/helper_functions.sh
source "$( dirname -- "${BASH_SOURCE[0]}" )"/db_helper_functions.sh

user="dbuser"
password="123" #Could be changed as to be a prompt in the future"
db_name="HomeTrackDB"
test_db_name="TestHomeTrackDB"
db_import_file="$( dirname -- "${BASH_SOURCE[0]}" )"/HomeTrackDB.sql

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
        sudo mysql -e "GRANT ALL PRIVILEGES ON ${test_db_name}.* TO '${user}'@'localhost';"
        sudo mysql -e "FLUSH PRIVILEGES;"
    fi
}

function importDB(){
    mysql -u"$user" -p"$password" "$db_name" < "$db_import_file"
}
function createDBTables(){
    echo_blue "Creating DB Tables"

    dbCommand "USE ${db_name}; \
               CREATE TABLE IF NOT EXISTS Satellite(
               Id int NOT NULL AUTO_INCREMENT,
               RoomId int NOT NULL,
               UpstreamSatelliteId int,
               HasTemperature bool NOT NULL,
               HasHumidity bool NOT NULL,
               HasVOC bool NOT NULL,
               HasAirParticle bool NOT NULL,
               HasAmbientLight bool NOT NULL,
               HasCurrent bool NOT NULL,
               PRIMARY KEY (Id)
               );"

    dbCommand "USE ${db_name}; \
               CREATE TABLE IF NOT EXISTS Room(
               Id int NOT NULL AUTO_INCREMENT,
               Name varchar(255),
               PRIMARY KEY (Id)
               );"
    dbCommand "USE ${db_name}; \
               CREATE TABLE IF NOT EXISTS PowerCircuit(
               Id int NOT NULL AUTO_INCREMENT,
               Name varchar(255),
               RoomId int NOT NULL,
               PRIMARY KEY (Id)
               );"
    dbCommand "USE ${db_name}; \
               CREATE TABLE IF NOT EXISTS CurrentSensor(
               Id int NOT NULL AUTO_INCREMENT,
               PowerCircuitId int NOT NULL,
               SatelliteId int NOT NULL,
               PRIMARY KEY (Id)
               );"
    dbCommand "USE ${db_name}; \
               CREATE TABLE IF NOT EXISTS Measurements(
               Id varchar(36) NOT NULL,
               SatelliteId int NOT NULL,
               Datetime int NOT NULL,
               MeasurementTypeId int NOT NULL,
               Value float NOT NULL,
               PRIMARY KEY (Id)
               );"
    dbCommand "USE ${db_name}; \
               CREATE TABLE IF NOT EXISTS MeasurementType(
               Id int NOT NULL,
               Name varchar(20),
               Units varchar(20),
               PRIMARY KEY (Id)
               );"
}

function populateMeasurementTypeTable(){
    dbCommand "USE ${db_name}; \
               INSERT INTO MeasurementType VALUES (1,'Ambient Light', 'Lux'), \
                                                  (2,'Humidity', '%'), \
                                                  (3,'Temperature', '°C'), \
                                                  (4,'Current', 'A'), \
                                                  (5,'VOC', 'Lux'), \
                                                  (6,'Air Particle count', 'μg/m³');"
}

function setupMySQL(){
    echo_blue "Setting up MySQL database"

    ensureServiceIsRunning mysql

    createDBUser

    importDB
}