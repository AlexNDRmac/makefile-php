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
  phpcs           Check Code Style with PHP CodeSniffer [opt.: path]
  phpmd           Check Code Style with PHP MessDetector [opt.: path]
  ---             --------------------------------------------------------------
  help            Show this help and exit

```

## Features:

- Run `PHP Mess Detector` from your project `vendor/bin` directory using your `phpmd.xml` or `phpmd.xml.dist`
- Run `PHP CodeSniffer` from your project `vendor/bin` directory using your `phpcs.xml` or `phpcs.xml.dist`

(*) under development
