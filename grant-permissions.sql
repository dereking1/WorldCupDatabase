CREATE USER 'fifaadmin'@'localhost' IDENTIFIED BY 'adminpw';
CREATE USER 'fan'@'localhost' IDENTIFIED BY 'fanpw';

-- Can add more users or refine permissions
GRANT ALL PRIVILEGES ON worldcupdb.* TO 'fifaadmin'@'localhost';
GRANT SELECT ON worldcupdb.* TO 'fan'@'localhost';
FLUSH PRIVILEGES;
