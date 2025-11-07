#!/usr/bin/env bash

test_single(){
  if [[ ${1##*.} == "gif" ]]; then
    swww img --fill-color=161616 "$1"
  else
    swww img --resize fit --fill-color=161616 "$1"
  fi
  if [[ $? -ne 0 ]]; then
    printf "Error: %s\n" "$1"
  fi
}

main(){
  folder=$1

  printf "Cheching folder %s\n" "$folder"

  for file in "$folder"/*; do
    if [[ -f "$file" ]]; then
      test_single "$file"
      sleep 0.1
    fi
  done
}

main "$@"
