#! /bin/bash
version: '3.5'

services:
  postgres_16_4:
    container_name: postgres_16_4
    image: postgres:16.4
    networks:
      - postgres16_4
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: <HASLO>
    volumes:
       - <CALA_SCIEZKA>/data:/var/lib/postgresql/data
       - <CALA_SCIEZKA_BACKUP>:/data/backup
    ports:
      - "<PORTY:PORTY>"
    restart: always

networks:
  postgres16_4:
    name: postgres16_4
    driver: bridge

### Usuwanie katalogów i plików starszych niz 14 dni dla backupu baz
30 01 * * * find /mnt/backup/postgres/11.13 -type d -mtime +13 | xargs rm -rf


DO BACKUPU KOMENDA
30 02 * * * docker exec -d -u postgres postgres11_13 bash -c "pg_basebackup -D /var/lib/postgresql/data/bck-$(date +\%Y\%m\%d-\%H-\%M-\%S) -F t -z -c fast"
