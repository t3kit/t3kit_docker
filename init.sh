#!/usr/bin/env bash

echo "Please provide the site folder name:"
read SITE_NAME

if [ ! "$SITE_NAME" ]; then
    echo "Site folder name is missing."
else
	echo "Initializing site with name: $SITE_NAME"

	if [ ! -d "shared" ]; then
		mkdir shared
	fi

	cd shared
	if [ ! -d "db" ]; then
		mkdir db
	fi
	cd db
	if [ ! -d .git ]; then
		echo "Cloning sample database from GitHub"
		git clone https://github.com/t3kit/t3kit_db.git .
	fi;
	cd ..

	NUMBER_OF_SHARED_FOLDERS=`find ./* -maxdepth 0 -type d | wc -l`

	if [ "$NUMBER_OF_SHARED_FOLDERS" == "2" ]; then

		echo "Site folder already exists."

	else
		echo "Creating folder, cloning from repository and running composer install"
		if [ ! -d "$SITE_NAME" ]; then
			mkdir "$SITE_NAME"
		fi
		cd "$SITE_NAME"
		if [ ! -d .git ]; then
			git clone https://github.com/t3kit/t3kit_composer.git .

			composer install

		fi;
	fi;
fi;
