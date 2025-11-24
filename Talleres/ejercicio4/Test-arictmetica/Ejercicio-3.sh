
#!/bin/bash

num1=2;
num2=100;

if (( $num1 > $num2 )); then
	echo "$num1 es mayor que $num2";
else
	echo "$num1 es menor que $num2";
fi
