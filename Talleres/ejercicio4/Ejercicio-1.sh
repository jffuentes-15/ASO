#!/bin/bash

echo "Se van a realizar una serie de comprobaciones";
echo "Si da 0 se ha ejecutado correctamente";
echo "Si dan distinto de 0 no se ha ejecutado correctamente";
echo " ";
echo "============================================================";
[[ -e /etc ]];
echo "Verificando si /etc existe:" $?;

[[ -r /etc/hosts ]];
echo "Verificando si /etc/hosts se puede acceder en modo lectura:" $?;

[[ -x /etc/hosts ]];
echo "Verificando si /etc/hosts se puede acceder en modo ejecucion:" $?;

[[ -d /prueba && -r /prueba ]];
echo "Verificando si el archivo /usr es un directorio y si se puede atravesar:" $?;
