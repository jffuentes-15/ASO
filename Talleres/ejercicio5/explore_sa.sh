#!/bin/bash

function FIN () {
	exit;
}


function limpieza () {
	find "$HOME" -type f -size 0 -exec rm -i {} \;
}

function sin_espacio_d () {
	SIZE=$(df | grep /$ | awk '{print $5}' | cut -d"%" -f1);

	if [[ $SIZE -gt 80 ]]; then
		echo "Tasa de utilización del sistema de archivos raíz: ALTA";
	else
		echo "Tasa de utilización del sistema de archivos raíz: NORMAL";
	fi
}


cat << EOF
0 - Fin
1 - Eliminar los archivos de tamaño 0 de mi directorio principal
2 - Controlar el espacio de disco del SA raíz
EOF

read -p "Su opcion: " opt

case $opt in 

	0)
		FIN;
	;;

	1)
		limpieza;
	;;

	2)
		sin_espacio_d;
	;;
esac
