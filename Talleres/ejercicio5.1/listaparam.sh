#!/bin/bash


function ERROR() {
cat << EOF
SYNOPSIS:
	$0 [cadena…]

DESCRYPTION:
	Muestra en líneas diferentes los parámetros que se han pasado al llamar
	al script. Cada línea incluye una etiqueta por delante del valor del
	parámetro indicando su posición ("el parametro 1 es:). Si se llama en
	vacío presenta por la salida estandard un texto explicativo de cómo se
	usa el script y finaliza.
EOF

exit 1;
}

if (( $# == 0 )); then
	ERROR;
fi

flag=1;

for PARAM in $@; do
	echo "El parametro $flag es: $PARAM";
	((flag++));
done;
