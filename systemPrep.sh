#! /bin/bash

echo "Witaj w skrypcie automatyzujacym przygotowanie systemu i deploy Jiry oraz bazy danych.Skrypt najlepiej wykonac z konta root lub z kontem z rownie wysokimi uprawnieniami."
sudo yum -y install docker >/dev/null 2>&1 &
