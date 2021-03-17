<?php
//logout.php
session_start();
session_unset();
session_destroy();
//redirigimos a login.php
header('Location: login.php');

