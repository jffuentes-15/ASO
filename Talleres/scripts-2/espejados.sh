#!/bin/bash

#declaracion de funciones


function ERROR () {
cat << EOF

SYNOPSIS:
        $0 direccionamiento_del_directorio

DESCRIPTION:
        Este script produce un archivo de nombre /var/tmp/
	$USER.mirror, el cual, contiene el nombre de cada uno
	de los archivos regulares ubicados por debajo del
	diretorio dado (a cualquier profundidad) junto con su
	espejado. Se debe verificar que el directorio existe en el
	sistema.  Cada línea del archivo debe responder al
	siguiente formato:

	fichero:orehcif

	El primer y unico parametro del script debera ser un direccionamiento valido
	de un direccionamiento valido, ya sea absoluto o relativo
===================================================================================
EXAMPLE:
	$0 /home/$USER

EOF
exit;
}


function CREAR () {
	rm /var/tmp/$USER.mirror 2>/dev/null;
	touch /var/tmp/$USER.mirror;

}


#==================================================================================



#comprobar que existe el directorio

if ! [[ -e $1 && -d $1 ]]; then
	ERROR;
fi

if [[ -e $2 ]]; then
	ERROR;
fi

#Llamar a la funcion CREAR para crear el fichero $USER.mirror
CREAR;

#variable de los archivos
FILES=( $(find $1 -type f -printf "%f\n" 2>/dev/null) );


#espejado

for FILE in "${FILES[@]}"; do
	l1=${#FILE};
	unset FILE_ESP;
	for (( i=l2; i >=0; i-- )); do
		FILE_ESP+="${FILE:$i:1}";
	done;
		echo "$FILE:$FILE_ESP" >> /var/tmp/$USER.mirror1;
done;

sort /var/tmp/$USER.mirror1 > /var/tmp/$USER.mirror;
rm /var/tmp/$USER.mirror1;
