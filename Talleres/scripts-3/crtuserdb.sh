#! /bin/bash

## funcion que calcula el siguiente uid disponible
function get_uid() {

while getent passwd $i >/dev/null; do
        ((i++));
done;

if (( i > $MAX )); then
        echo "ERROR";
        exit 1;
fi

put_uid=$i;
((i++));

}

## ************ MAIN ****************** ##

##! [[ -d $1 ]] && echo "El directorio dado no existe" && exit;
if ! [[ -d $1 ]]; then
	echo "El directorio dado no existe";
	exit;
fi

# Establece las variables permanentes.
F_CANDIDATO=$1/crtuserdb.candidato
F_USUARIOS=$1/crtuserdb.name
F_GRUPOS=$1/crtuserdb.group
F_SHELLS=$1/crtuserdb.shells

##( ! [[ -f $F_USUARIOS ]] || ! [[ -f $F_GRUPOS ]] || ! [[ -f $F_SHELLS ]] ) \
##&& echo "no existe alguno de los ficheros de base: $F_USUARIOS, $F_GRUPOS, $F_SHELLS" && exit;

if ! [[ -f $F_USUARIOS && -f $F_GRUPOS && -f $F_SHELLS ]]; then
	echo "No existe alguno de los ficheros base: $F_USUARIOS, $F_GRUPOS, $F_SHELLS";
	exit;
fi


# Averigua los valores inferior y superior del rango permitido para uid de usuarios
MAX=$(grep -w UID_MAX /etc/login.defs | cut -f2 -d"X"|tr -d '\t');
MIN=$(grep -w UID_MIN /etc/login.defs | cut -f2 -d"N"|tr -d '\t');
i=$MIN;

# Asegura la eliminacion del contenido de crtuserdb.candidato pero sin hacerlo desaparecer
echo "" > $F_CANDIDATO;

for u in $(cat $F_USUARIOS); do
# campo1 ------------------------
	campo1=$u;
# campo 2 -----------------------
	campo2="x";
# campo3 ------------------------
	get_uid;
	campo3=$put_uid;
# campo4 ------------------------
	group_check=$(grep -w ${u} $F_GRUPOS | cut -f2 -d":");
	if [ "$(cut -f1 -d':' /etc/group | grep -w ${group_check})" ]; then
		campo4=$(cut -d":" -f1,3 /etc/group | grep -w ${group_check} | cut -f2 -d":");
	else
		campo4=$(cut -d':' -f1,3 /etc/group | grep -w staff | cut -f2 -d ':');
	fi;
# campo6 ------------------------
	campo6="/home/${u}";
# campo7 ------------------------
	if [[ $(($campo3%2)) -ne 0 ]]; then
		campo7=$(grep -w 1 $F_SHELLS|cut -f2 -d":");
	else
		campo7=$(grep -w 2 $F_SHELLS|cut -f2 -d":");
	fi
# Suma una linea en crtuserdb.candidato ------------------------
	echo $campo1:$campo2:$campo3:$campo4::$campo6:$campo7 >> $F_CANDIDATO
done;
exit;
