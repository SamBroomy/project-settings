#!/usr/bin/env just --justfile

set shell := ["bash", "-uc"]
set dotenv-required := true
set dotenv-load := true
set export := true

COMMIT_HASH := `git rev-parse --short HEAD`

# List available recipes
_default:
    @just --list
