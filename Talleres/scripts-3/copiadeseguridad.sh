#!/bin/bash

function comprobar_root() {
    	if ! [[ $(id -u) -eq 0 ]]; then
		echo "Solo root puede ejecutar este script";
		exit 1;
	fi
}

function comprobar_parametros() {
    [[ $# -eq 2 ]] || { echo "Uso: $0 -c|-r directorio_base"; exit 1; }
    [[ "$1" == "-c" || "$1" == "-r" ]] || { echo "Parametro 1 debe ser -c o -r"; exit 1; }
    [[ "$2" = /* ]] || { echo "El directorio base debe ser direccionamiento absoluto"; exit 1; }
    [[ -d "$2" ]] || { echo "El directorio base debe existir"; exit 1; }
}

function obtener_usuarios_validos() {
    awk -F: '$3>=1000 && $6!="" && length($2)>0 {print $1 ":" $2 ":" $6 ":" $7}' /etc/passwd
}

function crear_ficheros_usuarios() {
    obtener_usuarios_validos > "$BASE/usuarios.txt"
    while IFS=: read -r user pass home shell; do
        [[ -d "$home" ]] || continue
        tar czf "$BASE/$user.tgz" -C "$home" .
    done < "$BASE/usuarios.txt"
}

function restaurar_usuario_si_no_existe() {
    useradd -m -d "$3" -s "$4" "$1"
    echo "$1:$2" | chpasswd -e
}

function restaurar_ficheros_usuario() {
    hdir=$(getent passwd "$1" | cut -d: -f6)
    tar xzf "$BASE/$1.tgz" -C "$hdir"
}

function restaurar_usuarios() {
    while IFS=: read -r user pass home shell; do
        if id "$user" >/dev/null 2>&1; then
            hdir=$(getent passwd "$user" | cut -d: -f6)
            tar xzf "$BASE/$user.tgz" -C "$hdir"
            currentpass=$(getent shadow "$user" | cut -d: -f2)
            [[ "$currentpass" == "!" || "$currentpass" == "*" ]] && echo "$user:$pass" | chpasswd -e
        else
            useradd -m -d "$home" -s "$shell" "$user"
            echo "$user:$pass" | chpasswd -e
            tar xzf "$BASE/$user.tgz" -C "$home"
            chown -R "$user":"$user" "$home"
        fi
    done < "$BASE/usuarios.txt"
}

function main() {
    comprobar_root
    comprobar_parametros "$@"
    ACCION="$1"
    BASE="$2"
    if [[ "$ACCION" == "-c" ]]; then
        crear_ficheros_usuarios
    else
        restaurar_usuarios
    fi
}

main "$@"
