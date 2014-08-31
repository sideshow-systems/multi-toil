<?php
ini_set('display_errors', 1);
error_reporting(E_ALL ^ E_NOTICE);

require 'vendor/autoload.php';

echo "hello world...";

Yii::import('system.utils.CController');
$timeTest = new CTimestamp();
print_r($timeTest);


echo "mep...";
?>
