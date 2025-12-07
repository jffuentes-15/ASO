#!/bin/bash

if ! [[ $USER == root ]]; then
	echo "no eres superusuario";
	exit;
fi

id $1 2> /dev/null 1>/dev/null;

if [[ $1 -z ]]; then

fi
