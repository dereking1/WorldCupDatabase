CREATE USER 'fifaadmin'@'localhost' IDENTIFIED BY 'adminpw';
CREATE USER 'fan'@'localhost' IDENTIFIED BY 'fanpw';

-- Can add more users or refine permissions
GRANT ALL PRIVILEGES ON fifa.* TO 'fifaadmin'@'localhost';
GRANT SELECT ON fifa.* TO 'fan'@'localhost';
FLUSH PRIVILEGES;
