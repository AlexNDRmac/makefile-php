# PHP Project Template

[![Build][actions badge]][actions link]

## Template for common PHP projects

This Template helps PHP developers with running most common PHP tools as simple as possible.

## How it looks

```txt
PHP Project Template v1.0.0

Usage: make <target> [ENV_VAR=VALUE ...] [ARGS="--tool-cli-args"]

Available targets:

  ---             ----------------------------------------------------
  phpcs           Run PHP_CodeSniffer inspection
  phpmd           Run PHP Mess Detector inspection
  tests           Run PHPUnit tests
  infection       PHP Mutation Testing
  ---             ----------------------------------------------------
  metrics         Generate PHP Metrics HTML report
  ---             ----------------------------------------------------
  help            Show this help and exit
```

## Features

- Run [PHP CodeSniffer][phpcs link] from your project `vendor/bin` directory using your `phpcs.xml` or `phpcs.xml.dist`
- Run [PHP Mess Detector][phpmd link] from your project `vendor/bin` directory using your `phpmd.xml` or `phpmd.xml.dist`
- Execute [PHPUnit][phpunit link] tests and generates code coverage html report
- Execute AST based [PHP Mutation Testing][infection link]
- Generates HTML reports with [Metrics][metrics link] about PHP project and classes


<!-- All external links should be here -->

[actions badge]:    https://github.com/AlexNDRmac/php-project-template/actions/workflows/main.yml/badge.svg
[actions link]:     https://github.com/AlexNDRmac/php-project-template/actions/workflows/main.yml
[phpcs link]:       https://github.com/squizlabs/PHP_CodeSniffer
[phpmd link]:       https://github.com/phpmd/phpmd
[phpunit link]:     https://github.com/sebastianbergmann/phpunit
[infection link]:   https://github.com/infection/infection
[metrics link]:     https://github.com/phpmetrics/PhpMetrics
