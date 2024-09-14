#! /bin/bash

echo "Witaj w skrypcie automatyzujacym przygotowanie systemu i deploy Jiry oraz bazy danych.Skrypt najlepiej wykonac z konta root lub z kontem z rownie wysokimi uprawnieniami."
yum install -y yum-utils # >/dev/null 2>&1 & --instalacja po cichu
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
yum -y update
