<?php

$host = "localhost";
$user = "luiscosta";
$pass = "123";
$db = "lbaw";

$con = pg_connect("host=$host dbname=$db user=$user password=$pass")
or die ("Could not connect to server\n");

$query = "SELECT VERSION()";
$rs = pg_query($con, $query) or die("Cannot execute query: $query\n");
$row = pg_fetch_row($rs);

echo $row[0] . "\n";

$query = "DROP TABLE IF EXISTS users";
pg_query($con, $query) or die ("Cannot execute query : $query\n");

$query = "
  CREATE TABLE users (
  userid int(11) NOT NULL AUTO_INCREMENT,
  username varchar(50) NOT NULL,
  display_name varchar(255) NOT NULL,
  password varchar(50) NOT NULL,
  email varchar(255) NOT NULL,
  key varchar(50) NOT NULL,
  validated varchar(100) NOT NULL,
  groupid int(11) NOT NULL DEFAULT '2',
  lastactive int(11) NOT NULL,
  showavt int(11) NOT NULL DEFAULT '1',
  banned int(11) NOT NULL,
  regtime int(11) NOT NULL,
  PRIMARY KEY (userid)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;";
pg_query($con, $query) or die ("Cannot execute query : $query\n");

pg_close($con);

?>