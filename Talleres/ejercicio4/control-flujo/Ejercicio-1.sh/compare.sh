#!/bin/bash

if ! [[ $# = 2 && -f $1 && -f $2 ]]; then
	echo "introduzca dos ficheros ordinarios";
fi

f1=$(find $1 -printf "%s");
f2=$(find $2 -printf "%s");

if (($f1 > $f2)); then
	echo "El fichero $1 es el mayor de los dos. Tamaño: $f1";
else
        echo "El fichero $2 es el mayor de los dos. Tamaño: $f2";

fi
