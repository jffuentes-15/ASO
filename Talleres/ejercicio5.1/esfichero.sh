#!/bin/bash


# ============================
#  FUNCIÓN DE ERROR / AYUDA
# ============================
function ERROR() {
cat << EOF
Uso:  $0 [ archivo [ archivo [ archivo [ archivo [ archivo ]]]]]

Cada parámetro debe ser una cadena alfanumérica sin caracteres especiales.
Se admiten hasta 5 parámetros.
EOF
exit 1
}

# ============================
#  VALIDACIÓN DE PARÁMETROS
# ============================

# Más de 5 parámetros → error
if [[ $# -gt 5 ]]; then
    ERROR
fi

# Verificar que todos son alfanuméricos
for p in "$@"; do
    if [[ ! "$p" =~ ^[[:alnum:]]+$ ]]; then
        ERROR
    fi
done

# ============================
#  BÚSQUEDA Y FILTRADO
# ============================

for name in "$@"; do

    # Buscar archivos con ese nombre, silenciando errores
    # Usamos -type f para asegurar que sean ficheros regulares
    mapfile -t resultados < <(find / -type f -name "$name" 2>/dev/null)

    # Para cada ruta encontrada:
    for fichero in "${resultados[@]}"; do

        # Comprobar permisos: lectura para u,g,o
        if [[ -r "$fichero" && -r "$fichero" && -r "$fichero" ]]; then
            # Imprimir salida EXACTA de ls -l
            ls -l "$fichero"
        fi

    done
done
