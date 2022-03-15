# WorldCupDatabase

Our data comes from:
https://www.kaggle.com/abecklas/fifa-world-cup 
https://github.com/mneedham/neo4j-worldcup/tree/master/data 

To load the data from the command-line into MySQL run the following commands:
$ cd files:
$ mysql --local-infile=1 -u root -p
mysql> source setup.sql;
mysql> source load-data.sql;
mysql> source setup-passwords.sql;
mysql> source setup-routines.sql;
mysql> source grant-permissions.sql;
mysql> source queries.sql; (for queries)
mysql> quit;
$ python3 app-admin.py
OR 
$ python3 app-client.py

Now, you should either be in the admin or the client program.
For admin:
(l) - log into the app with admin information
(a) - add a new World Cup into the fifa database
(q) - quit the python program

For client:
(g) - view all time top World Cup goal scorers
(y) - view World Cup winners by year
(w) - view teams with most World Cup titles
(q) - quit
