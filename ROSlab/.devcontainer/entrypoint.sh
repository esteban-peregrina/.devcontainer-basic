#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~ ONLY WHEN STARTING WITHOUT DEVCONTAINER ~~~~~~~~~~~~~~~~~~~~ #
# Create a python virtual environment
python3 -m venv /workspace/venv

# Print and execute the command given as an argument (if any) or start a shell
echo "Provided arguments : $@"
exec "$@"
