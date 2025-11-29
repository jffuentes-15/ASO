#!/bin/bash

archivo="alumnos.txt"

function imprimir_linea () {
    local nombre="$1"
    local clase="$2"
    local promedio="$3"

    printf "%-15s %-10s %10s\n" "$nombre" "$clase" "$promedio"
}

function procesar_archivo () {
    while IFS="|" read -r nombre clase promedio; do
        imprimir_linea "$nombre" "$clase" "$promedio"
    done < "$archivo"
}

procesar_archivo
