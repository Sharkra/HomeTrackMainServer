import sys
import mysql.connector  # connects to MySQL, is fully functional
from pathlib import Path



class TestDB(object):
    #(__file__).parent.joinpath("/Test_HomeTrackDB.sql")
    db_file_path=""
    dbname="TestHomeTrackDB"

    def __init__(self):
        self.db_file_path = Path(__file__).parent.resolve() / "Test_HomeTrackDB.sql"
        self.cursor = None
        self.createDatabase()
        self.conn = mysql.connector.connect(host="localhost",
                                    user="dbuser",
                                    password="123",
                                    database=self.dbname,
                                    charset='utf8mb4')
        self.populateDatabase()
        
    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_value, traceback):
        print("Removing test DB")
        self.dropDatabase()

    def createDatabase(self):
        conn = mysql.connector.connect(host="localhost",
                                    user="dbuser",
                                    password="123",)
        with conn.cursor() as cursor:
            cursor.execute("CREATE DATABASE IF NOT EXISTS %s;" % self.dbname)    

    def populateDatabase(self):
        fd = open(self.db_file_path, 'r')
        sqlFile = fd.read()
        fd.close()

        # all SQL commands (split on ';')
        sqlCommands = sqlFile.split(';')

        try:
            with self.conn.cursor() as cursor:
                for command in sqlCommands:
                    if command.strip() == "":
                        continue
                    print(f"Executing ", command)
                    cursor.execute(command)
            self.conn.commit()

        except Warning as warn:
            print('Warning: %s ' % warn + '\nStop.\n')
            sys.exit()
    
    def showDatabases(self):
        with self.conn.cursor() as cursor:
            cursor.execute("SHOW DATABASES;")
            for i in cursor:
                print(i)
    
    def showTables(self):
        with self.conn.cursor() as cursor:
            cursor.execute("SHOW TABLES;")
            for i in cursor:
                print(i)
    
    def getValues(self):
        with self.conn.cursor() as cursor:
            cursor.execute("Select * from Measurements;")
            for i in cursor:
                print(i)
    
    def dropDatabase(self):
        with self.conn.cursor() as cursor:
            cursor.execute("DROP DATABASE %s;"% self.dbname)

with TestDB() as db_manager:
    print("Showing DB's")
    db_manager.showDatabases()
    print("Showing tables")
    db_manager.showTables()
    input("Press Enter to continue...")
    db_manager.getValues()
