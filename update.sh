#!/bin/sh

for i in $(ls "$NUPK_REPOSITORY")
do
	source "$NUPK_REPOSITORY/$i/data"
	NEWVERSION=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
                        "https://repology.org/badge/latest-versions/$PRETTY_NAME.svg?header=" | \
             xmllint --xpath '//*[name()="text"]/text()' - | \
             awk -F ', ' 'NR == 1 {print $NF}')

	if [ $VERSION = "git" ]
	then
		printf "$NUPK_W \033[34;1m$i\033[0m retrieved from git, skipping...\n"
	elif [ $NEWVERSION = "-" ]
	then
		printf "$NUPK_X \033[31;1m$i\033[0m not found on Repology!\n"
	elif [ $NEWVERSION != $VERSION ]
	then
		printf "$NUPK_E \033[33;1m$i\033[0m does not match: "
		printf "you have \033[33;1m$VERSION\033[0m but \033[33;1m$NEWVERSION\033[0m is available\n"
	else
		printf "$NUPK_O \033[32;1m$i\033[0m is up to date: version \033[32;1m$NEWVERSION\033[0m\n"
	fi
done
