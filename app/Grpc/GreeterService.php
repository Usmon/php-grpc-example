<?php

namespace App\Grpc;

use Helloworld\GreeterInterface;
use Helloworld\HelloReply;
use Helloworld\HelloRequest;

class GreeterService implements GreeterInterface
{
    public function SayHello(HelloRequest $request): HelloReply
    {
        $reply = new HelloReply();
        $reply->setMessage('Hello, ' . $request->getName());
        return $reply;
    }
}

