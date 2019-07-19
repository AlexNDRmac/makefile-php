.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
Makefile: ;              # skip prerequisite discovery

# Detect OS
OS = $(shell uname -s)

SHELL ?= /bin/bash

# Set comma and space symbols for usage as substitution symbols
comma  = ,
space := # <- This Whitespace is Necessary for Substitution
space +=
