#!/usr/bin/env bash

swww_check(){
  for file in "$1"/*; do
    if [[ -f "$file" ]]; then
      swww_check_single "$file"
    fi
  done
}

swww_check_single(){
  if [[ ${1##*.} == "gif" ]]; then
    swww img --fill-color=161616 "$1"
  else
    swww img --resize fit --fill-color=161616 "$1"
  fi
  if [[ $? -ne 0 ]]; then
    printf "Error: %s\n" "$1"
  fi
}

hash_check(){
  find "$1" -type f -exec md5sum {} + | sort | uniq -w32 -dD
}

folder_recursive(){
  for dir in ./*; do
    if [[ "$dir" == ".git" || ! -d "$dir" ]]; then
      continue
    fi

    if [[ "$1" == "hash" ]]; then
      printf "== hash check of %s ==\n" "$dir"
      hash_check "$dir"
    elif [[ "$1" == "swww" ]]; then
      printf "== swww check of %s ==\n" "$dir"
      swww_check "$dir"
    else
      printf "== hash and swww check of %s ==\n" "$dir"
      swww_check "$dir"
      hash_check "$dir"
    fi
  done
}

main(){
  flag=$1

  case "$flag" in
    "h")
      echo "Hashing Images..."
      folder_recursive "hash"
      ;;
    "s")
      echo "Checking images integrity..."
      folder_recursive "swww"
      ;;
    "")
      echo "Cheching hashes and integrity..."
      folder_recursive ""
      ;;
  esac
}

main "$@"
