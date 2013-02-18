<?php

mysql_connect('33.33.33.100', 'user', 'password') or die(mysql_error());
mysql_select_db('app_db') or die(mysql_error());
echo "db ok.</br>";
echo "web: {$_SERVER['SERVER_ADDR']}</br>";

echo '<pre>';
print_r($_SERVER);
echo '</pre>';
