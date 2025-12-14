#!/bin/bash

# Script: intervalo
# Realiza operaciones según la posición de una letra del abecedario

# Generar lista de opciones 1-20 asociadas a letras
opciones=()
for i in {1..20}; do
    letra=$(printf "%b" "$(printf "\\x$(printf %x $((96 + i)))")")
    opciones+=("$letra")
done

# Opción 21
opciones+=("terminar")

PS3="Elige una opción (1-21): "

while true; do
    echo "----------------------------------------"
    echo " MENÚ DE OPCIONES"
    echo "----------------------------------------"

    select opcion in "${opciones[@]}"; do
        # Validación de entrada fuera de rango
        if [[ -z "$opcion" ]]; then
            echo "Opción inválida. Debe ser un número del 1 al 21."
            break
        fi

        # Si elige "terminar" → salir
        if [[ "$opcion" == "terminar" ]]; then
            echo "Programa terminado."
            exit 0
        fi

        # Obtener índice (posición)
        posicion=$REPLY   # REPLY indica el número de opción elegida

        # Rango 1–10 → cuadrado del número
        if (( posicion >= 1 && posicion <= 10 )); then
            echo "La letra '$opcion' está en la posición $posicion"
            echo "Cuadrado: $((posicion * posicion))"
            break
        fi

        # Rango 11–20 → cubo del número
        if (( posicion >= 11 && posicion <= 20 )); then
            echo "La letra '$opcion' está en la posición $posicion"
            echo "Cubo: $((posicion * posicion * posicion))"
            break
        fi
    done
done
