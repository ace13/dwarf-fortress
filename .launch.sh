#!/bin/sh

# set -euo pipefail

die() {
	echo ${1:-"Error occured."}
	exit 1
}

if [ -z $UID ]; then die "No user id set, aborting"; fi
if [ -z $GID ]; then die "No group id set, aborting"; fi

if [ ! -d /df_linux/data/init ]; then
	echo "First run, setting up initial data..."

	cat /df_linux/dfhack.init-example > /df_linux/data/dfhack.init
	cp -r /df_linux/data_real/* /df_linux/data/
	cp -r /df_linux/hack/scripts_real/* /df_linux/hack/scripts/

	echo "Initial setup done, your instance is located at ~/.dwarf-fortress"
else
	cat /df_linux/data/dfhack.init > /df_linux/dfhack.init
	/df_linux/dfhack
fi

chown $UID:$GID -R /df_linux/
