#!/bin/bash

#definicion de variables

num_procesos=$(ps -u $1 --no-header | wc -l);

antiguo=$(ps -u $1 --sort=start_time --no-header -o comm | head -n 1);

num_directorios=$(find / -user $1 -type d 2>/dev/null | wc -l);

num_ficheros=$(find / -user $1 -type f 2>/dev/null | wc -l);

size=$(find / -type f -user $1 -printf "%s\n" 2>/dev/null | awk '{suma += $1} END {print suma}');

max_fichero=$(find / -user $1 -type f 2>/dev/null -exec du -h {} + | sort -rh | head -n 1 | cut -f2);
#max_fichero=$(find -user $1 -type f -printf "%s %p\n" 2>/dev/null | sort -rh | head -n1 | awk '{print $2}');

max_size=$(find / -user $1 -type f 2>/dev/null -exec du -h {} + | sort -rh | head -n 1 | cut -f1);

min_fichero=$(find / -user $1 -type f 2>/dev/null -exec du -h {} + | sort -h | head -n 1 | cut -f2);

min_size=$(find / -user $1 -type f 2>/dev/null -exec du -h {} + | sort -h | head -n 1 | cut -f1);


#Estructura del informe

echo "USUARIO: $1";
echo "*****************************************************************";
echo "PROCESOS EN EJECUCIÓN USUARIO: $num_procesos";
echo "PROCESO MÁS ANTIGUO DEL USUARIO: $antiguo";
ps -u $1 --no-header -o comm;
echo "*****************************************************************";
echo "DIRECTORIOS DEL USUARIO: $num_directorios";
echo "FICHEROS REGULARES DEL USUARIO: $num_ficheros";
echo "TAMAÑO TOTAL FICHEROS USUARIO: $size B";
echo "ARCHIVO MAS GRANDE: $max_fichero";
echo "TAMAÑO: $max_size";
echo "ARCHIVO MAS PEQUEÑO: $min_fichero";
echo "TAMAÑO: $min_size";
echo "*****************************************************************";
