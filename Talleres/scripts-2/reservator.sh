#!/bin/bash

#Definicion de funciones
#======================================================================================

function ERROR () {
cat << EOF

SYNOPSIS:
	$0 [-verbose] palabra_reservada

DESCRIPTION:
	Busca en todos los ficheros contenidos en /etc/
	y que respondan al tipo shell script (de cualquiera de
	sus clases) la aparición de palabra_reservada como palabra
	aislada (no como subcadena). Si se llama en vacío, con
	más parámetros de los obligatorios o con parámetros
	incorrectos, presentará por la salida estandard un texto
	explicativo de cómo se usa el script y finaliza.

===================================================================================

	palabra_reservada: 
	[case | do | done | elif | else | esac | fi | for | function | if | in | select | then | until | while | time]

EXAMPLE:
        $0 -verbose if
	$0 do
EOF
exit;
}


function VERBOSE () {
	find /etc -type f -exec file {} + 2>/dev/null | grep -i 'shell script' | cut -d: -f1 | xargs grep -nrsw $1;

}

function RESERVADA () {
	find /etc -type f -exec file {} + 2>/dev/null | grep -i 'shell script' | cut -d: -f1 | xargs grep -nrsw $1 | cut -d: -f1,2;
}




#Estructura de control del flujo con if y case
#=======================================================================================

if [[ $1 == "-verbose" ]]; then

	if [[ -z "$3" ]]; then
		case $2 in

			case | do | done | elif | else | esac | fi | for | function | if | in | select | then | until | while | time)
			VERBOSE $2;
			;;

			"")
			echo "Debe introducir una palabra reservada";
			ERROR;
			;;

			*)
			echo "Debe introducir una palabra reservada valida";
			ERROR;
			;;
		esac
	else
		echo "Solo puede introducir una palabra reservada"
		ERROR;
	fi
else
	if [[ -z "$2" ]]; then
		case $1 in

			case | do | done | elif | else | esac | fi | for | function | if | in | select | then | until | while | time)
	                RESERVADA $1;
	                ;;

	                "")
	                echo "Debe introducir una palabra reservada";
	                ERROR;
	                ;;

	                *)
	                echo "Debe introducir una palabra reservada valida";
	                ERROR;
	                ;;
	        esac
	else
		echo "Solo puede introducir una palabra reservada"
		ERROR;
	fi
fi
