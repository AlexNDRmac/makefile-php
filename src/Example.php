<?php

declare(strict_type=1);

namespace Example;

final class Example
{
    /** @var string */
    private $name;

    /**
     * @param $name Example name
     */
    public function __construct(string $name)
    {
        $this->name = $name;
    }

    public function getName(): string
    {
        return $this->name;
    }
}
