#!/bin/bash

continue_instalation()
{
sleep 1
exit_flag=0
read -p "Czy kontynuowac instalacje pomimo za niewystarczajacych zasobow? [y/n]:" answer
case "${answer,,}" in
	y)
		sleep 0.5
		echo "Kontynuuje instalacje."
		exit_flag=1
		;;

	n)
		sleep 0.5
		echo "Przerywam instalacje."
		exit_flag=1
		;;

	*)
		sleep 0.5
		echo "Bledna odpowiedz, wybierz Y lub N."
		;;
esac
}

total_ram_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
total_ram_mb=$((total_ram_kb / 1024))
required_ram_mb=10240

sleep 1
echo "Sprawdzam pamiec RAM"
if [ "$total_ram_mb" -ge "$required_ram_mb" ];
then
	echo "Wystarczajaca ilosc pamieci RAM: ${total_ram_mb} MB"
else
	echo "Nie wystarczajaca ilosc pamieci RAM - ${total_ram_mb} MB dostepne, wymagane ${required_ram_mb} MB."
	exit_flag=0
	while [ "$exit_flag" = 0 ];
	do
		continue_instalation
	done
fi

cpu_cores=$(nproc)
required_cpu_cores=3

sleep 1
echo "Sprawdzam ilosc rdzeni CPU"
if [ "$cpu_cores" -ge "$required_cpu_cores" ]
then
	echo "Wystarczajaca ilosc rdzeni procesora: ${cpu_cores}"
else
	echo "Nie wystarczajaca ilosc rdzeni - ${cpu_cores} rdzenie dostepne, wymagane ${required_cpu_cores} rdzenie."
	while [ "$exit_flag" = 0 ];
	do
		continue_instalation
	done
fi

available_space_mb=$(df -m --output=avail "/srv" | tail -n 1)
required_space_mb=20480

sleep 1
echo "Sprawdzam dostepna przestrzen dysku na /srv"
if [ "$available_space_mb" -ge "$required_space_mb" ]
then 
	echo "Wystarczajaca przestrzen na dysku: ${available_space_mb}MB"
else
	echo "Nie wystarczajaca przestrzen na dyksu - ${available_space_mb}MB, wymagane ${required_space_mb}MB."
	while [ "$exit_flag" = 0 ];
	do
		continue_instalation
	done
fi
