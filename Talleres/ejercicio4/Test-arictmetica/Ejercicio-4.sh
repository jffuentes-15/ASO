#!/bin/bash

num1=3;
num2=5;
((res=$num1 + $num2));

echo $res;
echo "";
echo $num1+$num2=$((num1 + num2));
echo $num2+$num1=$((num2 + num1));
