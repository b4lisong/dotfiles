#!/usr/bin/env bash
set -euo pipefail
sudo apt update && sudo apt install -y $(grep -vE '^\s*#' ../packages/kali.txt)

