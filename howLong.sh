#! /bin/bash

seconds=0
minutes=0
hours=0 			#god pls stay at 0


while true;
do
	while [ "$seconds" -le 59 ];
	do
		if [ "$minutes" -le 9 ];
		then
			if [ "$seconds" -le 9 ];
			then
				printf "\r0$minutes:0$seconds"
			else
				printf "\r0$minutes:$seconds"
			fi
		else
                        if [ "$seconds" -le 10 ];
                        then
                                printf "\r$minutes:0$seconds"
                        else
                                printf "\r$minutes:$seconds"
                        fi

		fi
		seconds=$((seconds + 1))
		sleep 1
		printf "\r      \r"
	done
	minutes=$((minutes + 1))
	seconds=0
done
