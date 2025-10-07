#!/bin/bash

cowsay "El nombre del script es: $0"
echo " "
echo "============ encolumnado ==================="
todo=$*
num=1
for i in  $@; do
        echo "El parámetro $num es: $i"
        ((num++))
done
echo " "
echo "============ caracteres ===================="

num=1;
T=0;
for i in  $@; do
        c=${#i}
	echo "El parámetro $num contiene: ${#i} caracteres"
	T=$(( $T + $c ))
        ((num++))
done

echo " "
echo "============ resumen ==================="
echo "los parametros son: " $@
echo "el numero de parametros es: " $#
echo "el nunero de caracteres totales es: " $T #$(( ${#todo}-$#+1 ))  #Matematicas hijo
