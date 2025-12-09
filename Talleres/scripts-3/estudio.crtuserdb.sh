#!/bin/bash

function get_uid() {
	while getent passwd $i >/dev/null; do
		((i++));
	done

	if (( i > $MAX )); then
		echo "LIMITE SUPERADO";
		exit;
	fi

	nex_uid=$i;
	((i++));
}



if ! [[ -d $1 ]]; then
	echo "falta directorio";
	exit;
fi


F_NAME=$1/crtuserdb.name;
F_GROUP=$1/crtuserdb.group;
F_SHELLS=$1/crtuserdb.shells;
F_CANDIDATO=$1/crtuserdb.candidato;


if ! [[ -f $F_NAME && -f $F_GROUP && -f $F_SHELLS ]]; then
	echo "no existe alguno de los ficheros";
	exit;
fi

MIN=$(grep -w UID_MIN /etc/login.defs | awk '{print $2}');
MAX=$(grep -w UID_MAX /etc/login.defs | awk '{print $2}');
i=$MIN;


echo "" > $F_CANDIDATO;



for u in $(cat $F_NAME); do
	campo1=${u};
	campo2="x";

	get_uid;
	campo3=$nex_uid;

	check_group=$(grep -w $u $F_GROUP | cut -d":" -f2);
	if cut -d":" -f1,3 /etc/group | grep -w $check_group; then
		campo4=$(cut -d":" -f1,3 /etc/group | grep -w ${check_group} | cut -d":" -f2);
	else
		campo4=$(cut -d":" -f1,3 /etc/group | grep -w staff | cut -d":" -f2);
	fi

	campo6="/home/${u}";

	if [[ $(($campo3 % 2)) -ne 0 ]]; then
		campo7=$(grep "1" bash_p15/crtuserdb.shells | cut -f2 -d:);
	else
		campo7=$(grep "2" bash_p15/crtuserdb.shells | cut -f2 -d:);
	fi

	echo $campo1:$campo2:$campo3:$campo4::$campo6:$campo7 >> $F_CANDIDATO;

done;
exit;

