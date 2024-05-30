#!/bin/bash

SALT=$(head -qc 48 /dev/urandom)
DIR_ID=device_$(head -qc 12 /dev/urandom | hexdump -e '"%x"')

if [[ -d "$DIR_ID" ]]
then
	    exit
fi

mkdir -v "$DIR_ID"
touch "$DIR_ID"/salt
echo -n  "$SALT" > "$DIR_ID"/salt
