#!/bin/bash

echo "El nombre del script es:" $0;
echo " ";
echo "============ encolumnado ===================";
num=1
cont=0
for i in $@; do
	echo "El parametro $num es: $i";
	((num++));
done

echo " ";
echo "============ caracteres ====================";
num=1
for i in $@; do
	echo "El parametro $num contiene ${#i} caracteres"
	((num++));
	((cont=cont+${#i}));
done
TODO=$*
echo " ";
echo "============ resumen ===================";
echo "todos los parametros:" $*
echo "numero total de parametros:" $#
echo "Numero total de caracteres" $cont  #$((${#TODO}-$#+1))
