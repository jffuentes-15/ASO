#!/bin/bash

#ERRORES + fin
	#Nº de parametros insuficientes HECHO
	#Parametros de naturaleza incorrecta
	#Parametro1 incorrecto HECHO
	#en caso de p1=D P2!=0 HECHO
#if [[ $DIR == +([[:alnum:]]) ]]; then

function ERROR () {
cat << EOF
USAGE:
	$0 S|s|M|m NUMERO...
	$0 D|d|R|r NUMERO NUMERO

EXAMPLE:
	$0 S 3 4 1
	$0 R 5 1
EOF
exit;
}

function SUMA () {
	suma=0
	for i in "$@"; do
		(( suma += i ))
	done;
	echo $suma

}

function MULTIPLICACION () {
	multi=1
	shift
	for i in "$@"; do
                (( multi *= i ))
        done;
        echo $multi

}


function RESTA () {
	resta=$(( $2 - $3 ))
	echo $resta
}


function DIVISION () {
	div=$(( $2 / $3 ))
	echo $div
}

for num in "${@:2}"; do
        if ! [[ $num =~ ^[[:digit:]]+$ ]]; then
                echo "Alguno de los operadores no es un número.";
                ERROR;
        fi
done

if [[ $# -lt 3 ]]; then
	echo "Numero de parametros insuficientes, minimo 2 numeros"
	ERROR;
else
	case "$1" in
		M|m)
			MULTIPLICACION $@;
		;;
		S|s)
			SUMA $@;
		;;
		D|d)
			if [[ -z $4 ]]; then
				if (( $2 > $3 && $3 != 0 )); then
					DIVISION $@;
				else
					ERROR;
				fi
			else
				ERROR;
			fi
		;;
		R|r)
			if [[ -z $4 ]]; then
				RESTA $@;
			else
				ERROR;
			fi
		;;
		*)
			ERROR;
		;;
	esac

fi


