#!/usr/bin/env bash

query=$(awww query)
filepath="${query#*/*/*/*/*/}"
echo -e "    - $filepath" >> ./Flagged.md
