"""
CS121 Final
(Admin version)

Authors: Derek Ing, Daniel Li
Emails: ding@caltech.edu, dzli@caltech.edu

Our database is a FIFA World Cup dataset containing information about all past World Cups. 
Some of the information contained consists of the winning team, hosting country, goals scored, etc..  
Our application program is ranking the performances of players and countries in the World Cup 
by goals scored and number of titles, respectively.
"""
import sys
import mysql.connector

import mysql.connector.errorcode as errorcode

DEBUG = False


# ----------------------------------------------------------------------
# SQL Utility Functions
# ----------------------------------------------------------------------
def get_conn():
    """"
    Returns a connected MySQL connector instance, if connection is successful.
    If unsuccessful, exits.
    """
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user='fifaadmin',
          port='3306',
          password='adminpw',
          database='fifa'
        )
        print('Successfully connected.')
        return conn
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR and DEBUG:
            sys.stderr('Incorrect username or password when connecting to DB.')
        elif err.errno == errorcode.ER_BAD_DB_ERROR and DEBUG:
            sys.stderr('Database does not exist.')
        elif DEBUG:
            sys.stderr(err)
        else:
            sys.stderr('An error occurred, please contact the administrator.')
        sys.exit(1)

# ----------------------------------------------------------------------
# Functions for Command-Line Options/Query Execution
# ----------------------------------------------------------------------
def add_data():
    cursor = conn.cursor()
    year = input('Enter World Cup year: ')
    host_country = input('Enter host country: ')
    first_place = input('Enter winner: ')
    second_place = input('Enter second place: ')
    third_place = input('Enter third place: ')
    fourth_place = input('Enter fourth place: ')
    goals_scored = input('Enter total goals scored: ')

    args = (year, host_country, first_place, second_place,
            third_place, fourth_place, goals_scored)

    try:
        sql = "INSERT INTO tournaments VALUES (%s,%s,%s,%s,%s,%s,%s);"
        cursor.execute(sql, params=args)
        conn.commit()
        print(cursor.rowcount, "record inserted.")
        cursor.execute("SELECT * FROM country_wins;")
        rows = cursor.fetchall()
        for row in rows: 
            (country, wins) = row
            print('  ', f'"{country}"', f'({wins})', 'wins')
        return
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred.')
# ----------------------------------------------------------------------
# Functions for Logging Users In
# ----------------------------------------------------------------------
def log_in():
    """
    Prompts user for username and password to log in to database.
    """
    cursor = conn.cursor()
    username = input('Enter username: ')
    password = input('Enter password: ')
    func = "SELECT authenticate(%s, %s);"
    try:
        cursor.execute(func, (username, password))
        result = cursor.fetchone()
        if int(result[0]) == 1:
            print('Sucessfully logged in.')
        else:
            print('Invalid username or password.')
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred.')
# ----------------------------------------------------------------------
# Command-Line Functionality
# ----------------------------------------------------------------------

def show_admin_options():
    """
    Displays options specific for admins, such as adding new data <a>,
    logging in (l), and quitting (q).
    """
    print('What would you like to do? ')
    print('  (l) - login')
    print('  (a) - add new World Cup tournament data')
    print('  (q) - quit')
    print()
    while True:
        ans = input('Enter an option: ')[0].lower()
        if ans == 'q':
            quit_ui()
        elif ans == 'l':
            log_in()
        elif ans == 'a':
            add_data()
        else:
            print('Unkown option')


def quit_ui():
    """
    Quits the program, printing a good bye message to the user.
    """
    print('Good bye!')
    print('SIIIIUUUUU')
    exit()


def main():
    """
    Main function for starting things up.
    """
    show_admin_options()


if __name__ == '__main__':
    conn = get_conn()
    main()
