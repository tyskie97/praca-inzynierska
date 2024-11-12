#! /bin/bash

echo "Witaj w skrypcie automatyzujacym przygotowanie systemu i deploy Jiry oraz bazy danych. Skrypt najlepiej wykonac z konta root lub z kontem z rownie wysokimi uprawnieniami."
echo "Instaluje yum-utils."
yum install -y yum-utils # >/dev/null 2>&1 & --instalacja po cichu
echo "Dodaje repozytorium."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo "Instaluje wszystkie paczki wymagane do zainstalowania Dockera."
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Aktualizazja wszystkich paczek w systemie."
yum -y update
echo "Wlaczam service Docker-a oraz ustawiam automatyczne wlaczenie wraz z wystartowaniem systemu."
systemctl start docker.service
systemctl enable docker.service
echo "Tworze foldery w ktorych beda przechowywane pliki aplikacji dla Jiry oraz dla PostgreSQL
Jira przechowywana jest w /srv/docker/jira
PostgreSQL przechowywany jest w /srv/docker/psql"
mkdir -p /srv/docker/psql/data
mkdir -p /srv/docker/jira/data 
echo "Przygotowania systemu zakonczone, wykonuje skrypt przygotowania bazy danych."

./setUpDataBase.sh
