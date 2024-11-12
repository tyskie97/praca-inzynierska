#! /bin/bash

printf "\nWitaj w skrypcie automatyzujacym przygotowanie systemu i deploy Jiry oraz bazy danych. Skrypt najlepiej wykonac z konta root lub z konta z rownie wysokimi uprawnieniami."
printf "\nInstaluje yum-utils.\n"
show_loading() { 				# petla ktorej zadaniem jest uswiadomienie uzytkownika o wciaz dzialajacym procesie
        while true;
        do
                printf "\rDzialanie w trakcie (to moze zajac chwile)"
                for i in {1..5};
                do
                        printf "."
                        sleep 0.5
                done
        printf "\r                                                \r"
        done
}
show_loading &          			# wykonanie komendy w tle 
show_loading_PID=$!     			# pobranie numeru procesu ostatniej komendy w tym przypadku okna ladowania
yum install -y yum-utils  >/dev/null 2>&1 	# instalacja po cichu
kill "$show_loading_PID" 2>/dev/null

printf "\nDodaje repozytorium."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

printf "\nInstaluje wszystkie paczki wymagane do zainstalowania Dockera.\n"
show_loading &
show_loading_PID=$!
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null 2>&1
kill "$show_lading_PID" 2>/dev/null

printf "\nAktualizacja wszystkich paczek w systemie.\n"
show_loading &
show_loading_PID=$!
yum -y update >/dev/null 2>&1
kill "$show_loading_PID" 2>/dev/null

printf "\nWlaczam service Docker-a oraz ustawiam automatyczne wlaczenie wraz z wystartowaniem systemu."
systemctl start docker.service
systemctl enable docker.service

printf "\nTworze foldery w ktorych beda przechowywane pliki aplikacji dla Jiry oraz dla PostgreSQL
Jira przechowywana jest w /srv/docker/jira
PostgreSQL przechowywany jest w /srv/docker/psql"
mkdir -p /srv/docker/psql/data			# flaga -p pozwala na tworzenie zagniezdzonych folderow
mkdir -p /srv/docker/jira/data 

printf "\nPrzygotowania systemu zakonczone, wykonuje skrypt przygotowania bazy danych."
./setUpDataBase.sh
