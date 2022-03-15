# WorldCupDatabase

Our data comes from:
https://www.kaggle.com/abecklas/fifa-world-cup <br/>
https://github.com/mneedham/neo4j-worldcup/tree/master/data <br/>

To load the data from the command-line into MySQL run the following commands: <br/>
$ cd files: <br/>
$ mysql --local-infile=1 -u root -p <br/>
mysql> source setup.sql; <br/>
mysql> source load-data.sql; <br/>
mysql> source setup-passwords.sql; <br/>
mysql> source setup-routines.sql; <br/>
mysql> source grant-permissions.sql; <br/>
mysql> source queries.sql; (for queries) <br/>
mysql> quit; <br/>
$ python3 app-admin.py <br/>
OR <br/>
$ python3 app-client.py <br/>

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
