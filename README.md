# WorldCupDatabase

Our data comes from: <br/>
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

Now, you should either be in the admin or the client program. <br/>
For admin: <br/>
(l) - log into the app with admin information <br/>
(a) - add a new World Cup into the fifa database <br/>
(q) - quit the python program <br/>

For client: <br/>
(g) - view all time top World Cup goal scorers <br/>
(y) - view World Cup winners by year <br/>
(w) - view teams with most World Cup titles <br/>
(q) - quit <br/>
