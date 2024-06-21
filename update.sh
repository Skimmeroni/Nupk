#!/bin/sh

for i in $(ls "$NUPK_REPOSITORY")
do
	NAME=$(cat "$NUPK_REPOSITORY/$i/name")
	NEWVERSION=$(curl -s "https://repology.org/badge/latest-versions/$NAME.svg" |
			grep -Eo '[0-9]+(\.[0-9]*)*[,]? [0-9]+(\.[0-9]*)*</text></g>|-</text></g>' |
			awk -F ',' '{print $1}')
	OLDVERSION=$(cat "$NUPK_REPOSITORY/$i/version")

	if [ $OLDVERSION = "git" ]
	then
		printf "$NUPK_W \033[34;1m$i\033[0m was installed from git, skipping...\n"
	elif [ $NEWVERSION = "-</text></g>" ]
	then
		printf "$NUPK_X \033[31;1m$i\033[0m not found on Repology!\n"
	elif [ $NEWVERSION != $OLDVERSION ]
	then
		printf "$NUPK_E \033[33;1m$i\033[0m does not match: "
		printf "you have \033[33;1m$OLDVERSION\033[0m but \033[33;1m$NEWVERSION\033[0m is available\n"
	else
		printf "$NUPK_O \033[32;1m$i\033[0m is up to date: version \033[32;1m$NEWVERSION\033[0m\n"
	fi
done
