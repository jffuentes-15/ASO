#!/bin/bash

archivo="datos.txt"

function contar_ciudades() {
    declare -A tabla
    while IFS="|" read -r nombre codigo ciudad; do
        tabla["$ciudad"]=$(( tabla["$ciudad"] + 1 ))
    done < "$archivo"

    for ciudad in "${!tabla[@]}"; do
        echo "$ciudad => ${tabla[$ciudad]}"
    done | sort
}

function main() {
    contar_ciudades
}

main
