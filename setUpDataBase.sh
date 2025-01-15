#! /bin/bash

printf "\nRozpoczynam przygotowanie bazy danych."
printf "\nZostanie stworzony plik compose dla bazy. Proces obejmuje konfiguracje kluczowych zmiennych w pliku konfiguracyjnym."
printf "\nPlik znajduje sie w /srv/docker/psql"
printf "\nBaza danych zostanie wystawiona domyslnie na porcie 5432. Czy chcesz zmienic port? [y/N]"
read asnwer
if [[ $asnwer == "y"]]
then
	read -p "Prosze podaj numer portu, upewnij sie ze podany port jest poprawny: " PORT
else
then
	PORT=5432
fi
printf "\nPliki bazy danych zostana domyslnie zapisane w /srv/docker/psql/data. Czy chcesz zmienic miejsce? [y/N]"
read answer
if [[ $asnwer == "y"]]
then
        read -p "Prosze podaj miejsce skladowania plikow, upewnij sie ze miejsce jest poprawne: " DATA_DIR
else
then
        DATA_DIR=/srv/docker/psql/data
	mkdir -p $DATA_DIR
fi
printf "\n Czy chcesz przygotowac zautomatyzowany system backupow logicznych bazy danych? [y/N]"
read answer
if [[ $asnwer == "y"]]
then
	read -p "Backupy domyslnie beda przetrzymywane w /srv/docker/psql/backup. Czy chcesz zmienic miejsce? [y/N]"
	read answer
	if [[ $asnwer == "y"]]
	then
	        read -p "Prosze podaj miejsce skladowania backupow, upewnij sie ze miejsce jest poprawne: " BACKUP_DIR
	else
	then
        	BACKUP_DIR=/srv/docker/psql/backup
        	mkdir -p $BACKUP_DIR
	fi
printf "\n Nalezy zdefiniowac haslo do uzytkownika postgres w bazie danych."
while true;
do
	read -sp "\nWprowadz haslo:" PASSWORD				# Flaga -s pozwala schowac input uzytkownika co przydatne jest w przypadku wpisywania hasel
	
	read -sp "\nPotwierdz haslo:" PASSWORD_CONFIRMATION
	if [[ "$PASSWORD" == "$PASSWORD_CONFIRMATION" ]]; 
	then
		break
	else
		printf "\nPodane hasla nie sa identyczne. Prosze prowadz hasla ponownie."
	fi
done
printf "\n"
	

echo <<EOF > docker-compose.yml
version: '3.5'

services:
  postgres_16.4:
    container_name: postgres_16.4
    image: postgres:16.4
    networks:
      - postgres16_4
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: $PASSWORD
    volumes:
       - $DATA_DIR:/var/lib/postgresql/data
       - $BACKUP_DIR:/data/backup
    ports:
      - "$PORT:5432"
    restart: always

networks:
  postgres16.4:
    name: postgres16.4
    driver: bridge
EOF

### Usuwanie katalogów i plików starszych niz 14 dni dla backupu baz
#30 01 * * * find /mnt/backup/postgres/11.13 -type d -mtime +13 | xargs rm -rf


#DO BACKUPU KOMENDA
#30 02 * * * docker exec -d -u postgres postgres11_13 bash -c "pg_basebackup -D /var/lib/postgresql/data/bck-$(date +\%Y\%m\%d-\%H-\%M-\%S) -F t -z -c fast"
