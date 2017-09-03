#!/bin/bash

for file in `ls -a ./tmp/Pictures/*`; do
	echo "$file"
	tesseract "$file" "$file.txt"
	cat "$file.txt" | grep flag
done
