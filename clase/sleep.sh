#!/bin/bash

while ! ( find "/tmp/2024.8.flag" 2>/dev/null ); do
	sleep 2;
	echo "no se encuentra el fichero"
done



