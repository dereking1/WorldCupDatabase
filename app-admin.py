"""
This is a template you may start with for your Final Project application.
You may choose to modify it, or you may start with the example function
stubs (most of which are incomplete). An example is also posted
from Lecture 19 on Canvas.

For full credit, remove any irrelevant comments, which are included in the
template to help you get started. Replace this program overview with a
brief overview of your application as well (including your name/partners name).

Some sections are provided as recommended program breakdowns, but are optional
to keep, and you will probably want to extend them based on your application's
features.
"""
import sys
import mysql.connector

import mysql.connector.errorcode as errorcode

DEBUG = True


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
          database='worldcupdb'
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
    year = input('Enter World Cup year: ')[0]
    host_country = input('Enter host country: ')[0]
    first_place = input('Enter winner: ')[0]
    second_place = input('Enter second place: ')[0]
    third_place = input('Enter third place: ')[0]
    fourth_place = input('Enter fourth place: ')[0]
    goals_scored = input('Enter total goals scored: ')[0]

    args = [year, host_country, first_place, second_place,
            third_place, fourth_place, goals_scored]
    
    try:
        cursor.callproc('fifa_new_tournament', args=args)
        print('Sucessfully added new tournament!')
    except:
        print("Unexpected error:", sys.exc_info()[0])
        raise
# ----------------------------------------------------------------------
# Functions for Logging Users In
# ----------------------------------------------------------------------
def log_in():
    """
    Prompts user for username and password to log in to database.
    """
    cursor = conn.cursor()
    username = input('Enter username: ')[0]
    password = input('Enter password: ')[0]
    func = "SELECT authenticate(%s, %s);"
    try:
        cursor.execute(func, (username, password))
        result = cursor.fetchone()
        if r == 1:
            print('Successfully logged in.')
    except:
        print("Unexpected error:", sys.exc_info()[0])
        raise
# ----------------------------------------------------------------------
# Command-Line Functionality
# ----------------------------------------------------------------------

def show_admin_options():
    """
    Displays options specific for admins, such as adding new data <x>,
    modifying <x> based on a given id, removing <x>, etc.
    """
    print('What would you like to do? ')
    print('  (l) - login')
    print('  (a) - add new World Cup tournament data')
    print()
    ans = input('Enter an option: ').lower()
    while True:
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
