<?php

require 'vendor/autoload.php';

use Helloworld\GreeterService;
use Spiral\GRPC\Server;

$server = new Server();
$server->registerService(GreeterServiceInterface::class, new GreeterService());

$server->serve("0.0.0.0:50051");
