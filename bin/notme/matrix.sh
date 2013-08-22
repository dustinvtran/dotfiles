#!/bin/bash

clear
virtcent=$((`tput lines`/2))
horcent=$((`tput cols`/2-10))
tput setf 6
tput cup $virtcent $horcent && echo "entering the matrix"
sleep 1
tput cup $virtcent $horcent && echo "                   "
sleep 1
tput cup $virtcent $horcent && echo "entering the matrix"
sleep 1
tput cup $virtcent $horcent && echo "                   "
sleep 1
tput cup $virtcent $horcent && echo "connecting.        "
sleep .1
tput cup $virtcent $horcent && echo "connecting..       "
sleep .1
tput cup $virtcent $horcent && echo "connecting...      "
sleep .1
tput cup $virtcent $horcent && echo "connecting....     "
sleep .1
tput cup $virtcent $horcent && echo "connecting.....    "
sleep .1
tput cup $virtcent $horcent && echo "connecting......   "
sleep .1
tput cup $virtcent $horcent && echo "connecting.......  "
sleep .1
tput cup $virtcent $horcent && echo "connecting.......  "
sleep .1
tput cup $virtcent $horcent && echo "connecting.......  "
sleep .1
tput cup $virtcent $horcent && echo "connecting........ "
sleep .1
tput cup $virtcent $horcent && echo "connecting........."
sleep 1
tput cup $virtcent $horcent && echo "     CONNECTED     "
sleep 1
clear



tput setf 2
lines="$(tput lines)"
col="$(tput cols)"
for i in $(seq 1 200) ; do
max1=$((RANDOM%3))
max=$(($lines-$max1))
declare -a char1
char1=(`~/bin/notme/matrix_char.sh`)
declare -a char2
char2=(`~/bin/notme/matrix_char.sh`)
declare -a char3
char3=(`~/bin/notme/matrix_char.sh`)
declare -a char4
char4=(`~/bin/notme/matrix_char.sh`)
declare -a char5
char5=(`~/bin/notme/matrix_char.sh`)
declare -a char6
char6=(`~/bin/notme/matrix_char.sh`)
declare -a char7
char7=(`~/bin/notme/matrix_char.sh`)
declare -a char8
char8=(`~/bin/notme/matrix_char.sh`)
declare -a char9
char9=(`~/bin/notme/matrix_char.sh`)
declare -a char10
char10=(`~/bin/notme/matrix_char.sh`)

l=$((RANDOM%$lines))
l2=$((RANDOM%$lines))
l3=$((RANDOM%$lines))
l4=$((RANDOM%$lines))
l5=$((RANDOM%$lines))
l6=$((RANDOM%$lines))
l7=$((RANDOM%$lines))
l8=$((RANDOM%$lines))
l9=$((RANDOM%$lines))
l10=$((RANDOM%$lines))
c=$((RANDOM%$col))
c2=$((RANDOM%$col))
c3=$((RANDOM%$col))
c4=$((RANDOM%$col))
c5=$((RANDOM%$col))
c6=$((RANDOM%$col))
c7=$((RANDOM%$col))
c8=$((RANDOM%$col))
c9=$((RANDOM%$col))
c10=$((RANDOM%$col))

while [ $l -lt $max ] ; do
tput cup $l $c
echo ${char1[${l}]}
if [ $l2 -lt $max ] ; then
tput cup $l2 $c2
echo ${char2[${l}]}
fi
if [ $l3 -lt $max ] ; then
tput cup $l3 $c3
echo ${char3[${l}]}
fi
if [ $l4 -lt $max ] ; then
tput cup $l4 $c4
echo ${char4[${l}]}
fi
if [ $l5 -lt $max ] ; then
tput cup $l5 $c5
echo ${char5[${l}]}
fi
if [ $l6 -lt $max ] ; then
tput cup $l6 $c6
echo ${char6[${l}]}
fi
if [ $l7 -lt $max ] ; then
tput cup $l7 $c7
echo ${char7[${l}]}
fi
if [ $l8 -lt $max ] ; then
tput cup $l8 $c8
echo ${char8[${l}]}
fi
if [ $l9 -lt $max ] ; then
tput cup $l9 $c9
echo ${char9[${l}]}
fi
if [ $l10 -lt $max ] ; then
tput cup $l10 $c10
echo ${char10[${l}]}
fi


l=$(($l+1))
l2=$(($l2+1))
l3=$(($l3+1))
l4=$(($l4+1))
l5=$(($l5+1))
l6=$(($l6+1))
l7=$(($l7+1))
l8=$(($l8+1))
l9=$(($l9+1))
l10=$(($l10+1))
done
done


