#!/bin/bash

# ============================
# FUNCIÓN DE USO / ERROR
# ============================
function USO() {
cat << EOF
Uso:  $0  -c N | -p PATRON

-c N     Busca archivos regulares cuyo NOMBRE tenga longitud N (N entero > 0)
-p PAT   Busca archivos regulares cuyo NOMBRE coincida con PAT (alfanumérico)
EOF
exit 1
}

# ============================
# VALIDACIÓN DE PARÁMETROS
# ============================

# Deben ser exactamente 2 parámetros
if [[ $# -ne 2 ]]; then
    USO
fi

opcion=$1
argumento=$2

# Validar opción
if [[ "$opcion" != "-c" && "$opcion" != "-p" ]]; then
    USO
fi

# Validación según la opción seleccionada
if [[ "$opcion" == "-c" ]]; then
    # Debe ser un entero mayor que 0
    if ! [[ "$argumento" =~ ^[0-9]+$ && "$argumento" -gt 0 ]]; then
        USO
    fi
fi

if [[ "$opcion" == "-p" ]]; then
    # Solo caracteres alfanuméricos
    if ! [[ "$argumento" =~ ^[A-Za-z0-9]+$ ]]; then
        USO
    fi
fi

# ============================
# BÚSQUEDA
# ============================

if [[ "$opcion" == "-p" ]]; then
    # Buscar archivos cuyo nombre coincida EXACTAMENTE con el patrón
    find / -type f -name "$argumento" 2>/dev/null

else    # opción -c

    # Buscar archivos y filtrar por longitud del nombre (sin ruta)
    find / -type f 2>/dev/null | while read -r f; do
        nombre=$(basename "$f")
        if [[ ${#nombre} -eq "$argumento" ]]; then
            echo "$f"
        fi
    done

fi
