<?php
/**PHP autoload **/ 
require_once __DIR__ . '/vendor/autoload.php';

use Amp\Dispatcher;

/**Multi-thread worker **/
function work()
{
    /* Do some work */

    return 'result';
}

$dispatcher = new Amp\Dispatcher;

// call 2 functions to be executed asynchronously
$promise1 = $dispatcher->call('work');
$promise2 = $dispatcher->call('work');

$comboPromise = Amp\all([$promise1, $promise2]);
list($result1, $result2) = $comboPromise->wait();
