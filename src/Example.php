<?php

declare(strict_types=1);

namespace Example;

final class Example
{
    /** @var string */
    private $name;

    /**
     * @param string $name Example name
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
