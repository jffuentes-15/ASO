#!/bin/bash

s1=si;
s2=no;
vacia="";
arch1=informe.pdf;

[[ $s1 == $s2 ]];
	echo "s1 = s2:" $?;
[[ $s1 != $s2 ]];
	echo "s1 != s2:" $?;
[[ -z $vacia ]];
	echo "vacia esta vacia:" $?;
! [[ -z $vacia ]];
        echo "vacia esta vacia:" $?;
[[ $arch1 == *.doc ]];
	echo "arch1 termina en .doc:" $?;
[[ $arch1 == *.doc || $arch1 == *.pdf ]];
	echo "arch1 termina en .doc o en .pdf:" $?;
