#!/bin/bash

function esNum () {
    local valor="$1"
    [[ "$valor" =~ ^-?[0-9]+$ ]]
}

function suma () {
    local total=0
    local num
    for num in "$@"; do
        if esNum "$num"; then
            total=$(( total + num ))
        fi
    done
    echo "$total"
}

function producto () {
    local total=1
    local num
    local valido=0

    for num in "$@"; do
        if esNum "$num"; then
            total=$(( total * num ))
            valido=1
        fi
    done


    if [[ $valido -eq 0 ]]; then
        echo 0
    else
        echo "$total"
    fi
}






if [[ $# -lt 2 ]]; then
    echo "Uso: $0 {suma|producto} num1 num2 ..."
    exit 1
fi

operacion="$1"
shift 1

case "$operacion" in
    suma)
        suma "$@"
        ;;
    producto)
        producto "$@"
        ;;
    *)
        echo "Operación no válida. Use: suma o producto"
        exit 1
        ;;
esac

