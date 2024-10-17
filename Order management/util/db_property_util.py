import configparser

class DBPropertyUtil:
    @staticmethod
    def get_connection_string(property_file):
        config = configparser.ConfigParser()
        config.read(property_file)
        return config['database']['connection_string']
