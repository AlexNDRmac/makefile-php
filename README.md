# PHP Makefile

[![CircleCI](https://img.shields.io/circleci/build/github/AlexNDRmac/makefile-php?style=flat-square)](https://circleci.com/gh/AlexNDRmac/makefile-php)

## Makefile for common PHP projects

This Makefile helps PHP developers with running all necessary PHP tools as simple as possible. You can use this Makefile on local machine and various CI and with PHPStorm as `Run configurations`

You don't need to deeply know how to configure all Tools for Laravel or any other project, Makefile already have configuration Templates for all Tools (of course you can modify it if you wish).

## How it looks

```
                                                                 
██████╗ ██╗  ██╗██████╗     ███╗   ███╗ █████╗ ██╗  ██╗███████╗
██╔══██╗██║  ██║██╔══██╗    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝
██████╔╝███████║██████╔╝    ██╔████╔██║███████║█████╔╝ █████╗  
██╔═══╝ ██╔══██║██╔═══╝     ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝  
██║     ██║  ██║██║         ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗
╚═╝     ╚═╝  ╚═╝╚═╝         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
                                                                 
Usage:
  make -f php.mk <target> <target options>

Example:
  make -f php.mk phpcs
  make -f php.mk phpmd ./App

Targets:

  ---             --------------------------------------------------------------
  phpcs           Check code style with PHP CodeSniffer [opt.: path]
  php-cs-fixer    Check code style with PHP CS Fixer (show diff only)
  phpmd           Check code Style with PHP MessDetector [opt.: path]
  ---             --------------------------------------------------------------
  help            Show this help and exit

```

## Features:

- Run `PHP Mess Detector` from your project `vendor/bin` directory using your `phpmd.xml` or `phpmd.xml.dist`
- Run `PHP CodeSniffer` from your project `vendor/bin` directory using your `phpcs.xml` or `phpcs.xml.dist`
- Run `PHP CodeFixer` from your project `vendor/bin` directory using your `.php_cs` or `php_cs.dist`

## How to run from command line:

- Just copy or create symlink `php.mk` to yor PHP project root
- Create (if not already exists) directory for logs: `./storage/logs`
- Run make with file `php.mk`

## Examples:

When you run `phpmd` target of `php.mk`, makefile detects automatically your rules file for MessDetector (`phpmd.xml` or `phpmd.xml.dist`).
If any configuration file not found - all available phpmd rules will be used: `cleancode,codesize,controversial,design,naming,unusedcode`

When you run `php.mk phpmd` without any args (directory path) - by defaults, will be used filter for changed `php` files if they changed or `current project directory` path

```bash
make -f php.mk phpmd ./Library,unit-tests 

## Example output:
PHPMD 2.7.0snapshot201907302127
config:  /path-to-your-project/phpmd.xml.dist
./Library/ArgInfoDefinition.php:17	The class ArgInfoDefinition has an overall complexity of 51 which is very high. The configured complexity threshold is 50.
...
FAILURE!
```

(*) under development
