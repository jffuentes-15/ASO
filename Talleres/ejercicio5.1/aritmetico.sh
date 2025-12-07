#!/bin/bash

function error () {
cat << EOF
SYNOPSIS
	aritmetico.sh numero

	numero debe ser un valor entero positivo y distinto de cero.
EOF

exit;
}

function producto () {
	resultado=$(( $1 * $1 ));
	echo "$1 * $1 = $resultado"
}

function suma () {
        resultado=$(( $1 + $1 ));
        echo "$1 + $1 = $resultado"
}

if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
	error;
fi

producto $1;

suma $1
