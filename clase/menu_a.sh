#! /bin/bash
PS3="Elije un color==>";

select color in rojo azul verde SALIR; 
	do
		if [[ "$color" == "SALIR" ]]; then
			exit;
		fi
		if [[ "$color" != "rojo" && "$color" != "azul" && "$color" != "verde" ]]; then
			echo "Elije un valor valido";
		else
			echo "has elegido" $color;
		fi

	done
