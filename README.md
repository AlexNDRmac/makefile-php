# Makefile-php

## Makefile for Laravel projects

This Makefile helps PHP developers with runnig all necessary php tools as simple as possible. You can use this Makefile on local machine and various CI.

You don't need to deeply know how to configure all Tools for Laravel project, Makefile already have configuration Templates for all Tools (of course you can modify it if you wish).

```bash
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            __  ___      __        _____ __           ____  __  ______ 
           /  |/  /___ _/ /_____  / __(_) /__        / __ \/ / / / __ \
          / /|_/ / __ `/ //_/ _ \/ /_/ / / _ \______/ /_/ / /_/ / /_/ /
         / /  / / /_/ / ,< /  __/ __/ / /  __/_____/ ____/ __  / ____/ 
        /_/  /_/\__,_/_/|_|\___/_/ /_/_/\___/     /_/   /_/ /_/_/      
                                                                       
--------------------------------------------------------------------------------
        Makefile for Laravel projects
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Usage:
  make [target] [arguments]

Targets:

  ---             --------------------------------------------------------------
  install         Install all PHP Tools (skip existing tools in ./vendor/bin)
  check-tools     Check all Tools
  ---             --------------------------------------------------------------
  help            Show this help and exit
```

## Features:

- Install PHP tools
- Check tools
- Run Unit, Feature, Integration Tests with PHPUnit
- Run Mutation Tests with Infection
- Analyze project with PHPStan, CodeSniffer, Mess Detector, PHP Metrics
- Generate Code Coverage report

(*) under development
