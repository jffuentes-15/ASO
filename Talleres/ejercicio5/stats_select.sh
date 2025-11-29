#!/bin/bash

archivo="alumnos.txt"

function imprimir_linea () {
    local nombre="$1"
    local clase="$2"
    local promedio="$3"
    printf "%-15s %-10s %10s\n" "$nombre" "$clase" "$promedio"
}

function mostrar_clase () {
    local buscada="$1"
    while IFS="|" read -r nombre clase promedio; do
        if [[ "$nombre" == "Nombre" ]]; then
            continue
        fi
        if [[ "$clase" == "$buscada" ]]; then
            imprimir_linea "$nombre" "$clase" "$promedio"
        fi
    done < "$archivo"
}

function promedio_clase () {
    local buscada="$1"
    local suma=0
    local count=0
    local promedio
    while IFS="|" read -r nombre clase nota; do
        if [[ "$nombre" == "Nombre" ]]; then
            continue
        fi
        if [[ "$clase" == "$buscada" ]]; then
            echo "Nota : $nota"
            suma=$((suma + nota))
            count=$((count + 1))
        fi
    done < "$archivo"

    if [[ $count -gt 0 ]]; then
        promedio=$((suma / count))
        echo "Promedio de la clase de $buscada: $promedio"
    else
        echo "No hay alumnos en esa clase."
    fi
}




PS3="Su opción: "





select opcion in "Extracto por clase" "Promedio por clase" "Fin"; do
    case "$opcion" in
        "Extracto por clase")
            echo -n "Clase ? "
            read clase
            echo
            mostrar_clase "$clase"
            echo
            ;;
        "Promedio por clase")
            echo -n "Clase ? "
            read clase
            echo
            promedio_clase "$clase"
            echo
            ;;
        "Fin")
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida."
            ;;
    esac
done
