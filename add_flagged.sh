#!/usr/bin/env bash

query=$(swww query)
filepath="${query#*/*/*/*/*/}"
echo -e "    - $filepath" >> ./Flagged.md
