#!/usr/bin/env bash
set -euo pipefail

id
printf '%s\n' 'Running the sample application tests.'
python3 -m unittest discover -s tests -v
