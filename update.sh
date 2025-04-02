#!/bin/sh

for i in $(ls -1 "$NUPK_REPOSITORY")
do
	VERSION=$(grep '^VERSION' "$NUPK_REPOSITORY/$i/build" | awk -F '=' '{print $2}')
	PRETTY_NAME=$(grep '^PRETTY_NAME' "$NUPK_REPOSITORY/$i/build" | awk -F '=' '{print $2}')
	NEWVERSION=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" \
	             "https://repology.org/badge/latest-versions/$PRETTY_NAME.svg?header=" | \
	             xmllint --xpath '//*[name()="text"]/text()' - | \
	             awk -F ', ' 'NR == 1 {print $NF}')

	if [ $VERSION = "git" ]
	then
		printf "\033[34;1m$i\033[0m retrieved from git, skipping...\n"
	elif [ $NEWVERSION = "-" ]
	then
		printf "\033[31;1m$i\033[0m not found on Repology!\n"
	elif [ $NEWVERSION != $VERSION ]
	then
		printf "\033[33;1m$i\033[0m does not match: "
		printf "you have \033[33;1m$VERSION\033[0m but \033[33;1m$NEWVERSION\033[0m is available\n"
	else
		printf "\033[32;1m$i\033[0m is up to date: version \033[32;1m$NEWVERSION\033[0m\n"
	fi
done
