#!/bin/bash

#Comprobar si $1 esta bacio, si esta facio fin;
#si no esta bacio escribir $1 intercalando el caracter - entre cada posicion h-o-l-a
#proceso de espejo
#escribir $1 espejado

#recurso1- Expansion de parametro para introducir cada posicion en un vector T1[@]
#completas un vector del mismo tamaño pero introduciendo las posiciones espejadas T2[@]

function ERROR () {
cat << EOF
USAGE:
	$0 TEXT

RESULT:
	TXET

DESCRIPTION:
	You type only first positional parameter and it will type by standar output
	on reverse
EOF
exit;
}


if [[ -z $1 ]]; then
	ERROR
fi


LIMITE=$((${#1}-1))
unset ROTO;
for (( i=0; $i<=$LIMITE; i++ )); do
	ROTO=$ROTO-${1:$i:1};
done;
echo ${ROTO:1};
