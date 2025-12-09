#!/bin/bash

function ERROR() {
cat << EOF
ESTA MALL
EOF

exit;
}

function FILES() {
	find $1 -mindepth 1 -printf "%d %y %f\n" \
        | awk '{
                tabulacion = ($1 - 1)*6
                simbolo = ($2 == "d" ? "+" : "-")

                printf "%*s%s%s\n", tabulacion, "", simbolo, $3

                if($2 == "d") dirs++
                else if($2 == "f") fich++

                } END {
                print "Total directorios:", dirs
                print "Total ficheros regulares:", fich
                }';
        exit 0;

}

function TREE() {
	find $1 -mindepth 1 -type d -printf "%d %f\n" 2>/dev/null | awk '{ printf "%*s%s\n", ($1-1)*6, "", $2}'
}


if [[ $1 != -f ]]; then
	if [[ -z $1 ]]; then
		echo "introduce un parametro";
		ERROR;
	fi

	if ! [[ $1 = /* && -d $1 ]]; then
		echo "$1 no es un direccionamiento absoluto o no existe";
		ERROR;
	else
		TREE $1;
	fi

	if ! [[ -z $2 ]]; then
		echo "introduce solo un parametro";
		ERROR;
	fi
else
	if [[ -z $2 ]]; then
		echo "Parametros insuficientes";
		ERROR
	fi

	if ! [[ $2 = /* && -d $2 ]]; then
                echo "$2 no es un direccionamiento absoluto o no existe";
		ERROR;
	else
		FILES $2;
        fi

	if ! [[ -z $3 ]]; then
		echo "Demasiados parametros";
		ERROR;
	fi
fi
