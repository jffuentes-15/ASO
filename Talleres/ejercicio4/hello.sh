#!/bin/bash

read -p "Introduzca su nombre: " NAME;

read -p "Introduzca sus apellidos: " LAST;

echo "Buenos días $NAME $LAST";

echo "El PID del shell es $BASHPID";

exit;
