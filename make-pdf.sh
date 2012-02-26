#!/bin/sh

# Basic format 8601 timestamp
NOW=$(date '+%Y%m%dT%H%M%S')
DIR=$(pwd)
ORG="$1"
HTML="${1%.org}.html"
PDF="${1%.org} $NOW.pdf"

echo "\nGenerating '$HTML' ...\n"
emacs --quick --batch --eval \
"(progn 
(require 'org)
(setq org-export-html-coding-system 'utf-8)
(find-file (expand-file-name \"$ORG\" \"$DIR\"))
(org-export-as-html nil nil nil nil nil)
(kill-buffer))"

echo "\nGenerating '$PDF' ...\n"
prince --media=print "$HTML" -o "$PDF" 

if [ "$?" -ne "0" ]; then
  echo "\nSorry, problem generating PDF"
  exit 1
fi

echo "\nDone"
exit 0
