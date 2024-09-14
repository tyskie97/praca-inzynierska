#! /bin/bash

echo "Witaj w skrypcie automatyzujacym przygotowanie systemu i deploy Jiry oraz bazy danych.Skrypt najlepiej wykonac z konta root lub z kontem z rownie wysokimi uprawnieniami."
yum install -y yum-utils # >/dev/null 2>&1 & --instalacja po cichu
echo ">>>>>>>>>=================
AFTER INSTALACJA YUM-UTILIS
>>>>>>>>>================="
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo ">>>>>>>>============
AFTER DODANIE REPO
>>>>>>>=============="
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo ">>>>>>>>>>>================
AFTER INSTALACJE PACZEK DOCKERA
>>>>>>>>>>>==============="
yum -y update
echo ">>>>>>>>>================
AFTER UPDATE SYSTEMU
>>>>>>>>>>>==============="
systemctl start docker.service
systemctl enable docker.service
echo ">>>>>>>>>>============
AFTER WLACZENIE I ENABLE DOCKER SERVICE
>>>>>>>>>>>>============"
