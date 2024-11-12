#! /bin/bash

echo "Witaj w skrypcie automatyzujacym przygotowanie systemu i deploy Jiry oraz bazy danych. Skrypt najlepiej wykonac z konta root lub z konta z rownie wysokimi uprawnieniami."
echo "Instaluje yum-utils."
show_loading() { 				# petla ktorej zadaniem jest uswiadomienie uzytkownika o wciaz dzialajacym procesie
        while true;
        do
                printf "\rDzialanie w trakcie (to moze zajac chwile)"
                for i in {1..5};
                do
                        printf "."
                        sleep 0.3
                done
        printf "\r            \r"
        done
}
show_loading &          			# wykonanie komendy w tle 
show_loading_PID=$!     			# pobranie numeru procesu ostatniej komendy w tym przypadku okna ladowania
yum install -y yum-utils  >/dev/null 2>&1 	# instalacja po cichu
kill "$show_loading_PID" 2>/dev/null

echo "Dodaje repozytorium."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "Instaluje wszystkie paczki wymagane do zainstalowania Dockera."
show_loading &
show_loading_PID=$!
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null 2>&1
kill "$show_lading_PID" 2>/dev/null

echo "Aktualizazja wszystkich paczek w systemie."
show_loading &
show_loading_PID=$!
yum -y update >/dev/null 2>&1
kill "$show_loading_PID" 2>/dev/null

echo "Wlaczam service Docker-a oraz ustawiam automatyczne wlaczenie wraz z wystartowaniem systemu."
systemctl start docker.service
systemctl enable docker.service

echo "Tworze foldery w ktorych beda przechowywane pliki aplikacji dla Jiry oraz dla PostgreSQL
Jira przechowywana jest w /srv/docker/jira
PostgreSQL przechowywany jest w /srv/docker/psql"
mkdir -p /srv/docker/psql/data			# flaga -p pozwala na tworzenie zagniezdzonych folderow
mkdir -p /srv/docker/jira/data 

echo "Przygotowania systemu zakonczone, wykonuje skrypt przygotowania bazy danych."
./setUpDataBase.sh
