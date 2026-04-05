#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
stow -v -t "$HOME" --no-folding "$@"
