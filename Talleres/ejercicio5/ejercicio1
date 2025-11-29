#!/bin/bash

opt1="Fin";
opt2="Mostrar la lista de usuarios conectados";
opt3="Mostrar el espacio en disco";
PS3="Su opción:";

function users_connect () {
	echo "Usuarios conectados:";
	who | cut -d" " -f1;
	exit;
}

function disk_space () {
	M=$(df -BM | grep /$ | awk '{print $4}');
	G=$(df -BG | grep /$ | awk '{print $4}');
	echo "Espacio en disco disponible: $M/$G";
	exit;
}


select opt in "$opt1" "$opt2" "$opt3" ; do
	case $opt in
		$opt1)
			exit;
		;;

		$opt2)
			users_connect;
		;;

		$opt3)
			disk_space;
		;;
	esac

done
