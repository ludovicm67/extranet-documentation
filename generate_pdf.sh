#!/bin/sh

# useful variables for after
DIR="$(pwd)"
FILES="${DIR}/*_*.md"
CONTENT=""

# get the content of the report
for FILE in $FILES; do
  CONTENT="${CONTENT}\n\n$(cat $FILE)\n"
done

# generate a pdf file with the content
echo "${CONTENT}\n" \
  | pandoc -S --toc -o documentation.pdf \
    -V lang=fr -V fontsize=12pt -V documentclass=report

# clean temp files
rm -f texput* *.tex
