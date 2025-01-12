#! /bin/bash

version: '3'
services:
  jira:
    container_name: jira_8_22
    image: atlassian/jira-software:8.22.0 # wczesniej atlassian/jira-software:8.22
    #networks:
    # - postgres11_13
    environment:
     - 'JVM_MINIMUM_MEMORY=3072m'
     - 'JVM_MAXIMUM_MEMORY=16G'
     - 'ATL_PROXY_NAME=jira.envelo.pl'
     - 'ATL_PROXY_PORT=443'
     - 'ATL_TOMCAT_SCHEME=https'
     - 'ATL_TOMCAT_SECURE=true'
    extra_hosts:
     - "jira.envelo.pl:10.93.20.10"
    volumes:
     - ./data:/var/atlassian/application-data/jira
     - ./config_files:/opt/atlassian/jira/atlassian-jira
     - ./cacerts/cacerts:/opt/java/openjdk/lib/security/cacerts:ro
    ports:
     - '8880:8080'
    restart: always
    logging:
     driver: "json-file"
     options:
       max-size: "5m"
       max-file: "10"
#networks:
#  postgres11_13:
#    external: true
#    name: postgres11_13


