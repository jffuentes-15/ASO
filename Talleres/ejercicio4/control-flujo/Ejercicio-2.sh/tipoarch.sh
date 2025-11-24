#!/bin/bash

for file in $@; do
	case $file in

		*.doc)
			echo "$file: Archivo DOC";
		;;

		*.pdf)
			echo "$file: Archivo PDF";
		;;

		*)
			echo "$file: Ni DOC, ni PDF";
		;;
	esac

done
