#!/bin/bash


if [[ $USER == root ]]; then
	echo "Eres root, el dios supremo y administrador del sistema";
else
	echo "Eres $USER, un usuario corriente no eres el dios root"
fi
