<?php

declare(strict_types=1);

namespace Tests\Unit;

use Tests\TestCase;
use Example\Example;

class ExampleTest extends TestCase
{
    public function testExample(): void
    {
        $test = new Example('hello world');

        $this->assertEquals('hello world', $test->getName());
    }
}
