import sqlite3
from util.db_property_util import DBPropertyUtil

class DBConnUtil:
    @staticmethod
    def get_db_conn(property_file):
        connection_string = DBPropertyUtil.get_connection_string(property_file)
        return sqlite3.connect(connection_string)
