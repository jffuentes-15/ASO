#!/bin/bash

function ERROR() {
cat << EOF
SYNOPSIS:
	$0 'permisos_modo_numerico'

EXAMPLE:
	$0 777

DESCRYPTION:
	A partir del directorio de trabajo modifica recursivamente los permisos
	de los archivos regulares que pertenezcan al usuario que ejecuta el
	script. El usuario root no puede ejecutar el script. Si se llama en vacío,
	con menos parámetros de los obligatorios o con parámetros incorrectos,
	presentará por la salida standard un texto explicativo de cómo se usa el
	script y finaliza.
EOF
exit 1;
}


if [[ $USER == root ]]; then
	ERROR;
fi

if [[ $# -ne 1 ]]; then
    ERROR;
fi

PERMISOS="$1";

if ! [[ "$PERMISOS" =~ ^[0-7]{3}$ ]]; then
    ERROR;
fi

find "$PWD" -type f -user "$USER" -exec chmod "$PERMISOS" {} \; 2>/dev/null;

exit 0;
