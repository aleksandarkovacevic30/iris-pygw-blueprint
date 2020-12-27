# IRIS Python Gateway Blueprint

This repository is a mini blueprint of how you can communicate with Python using Python Gateway, a new feature available in InterSystems IRIS Data Platform 2020.3+

This blueprint is contains two containers:

- iris: a basic setup is being made to enter a python gateway as a new object gateway
- python: a basic structure to develop python applications using multi-stage approach to build an application and run it on minimal required footprint. A [InterSystems Python Gateway](https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=BPYGATE) is a new feature which enables you to invoke python created classes within InterSystems objectscript and incorporate it within your application.

## Requirements

- Docker
- access to docker hub

## How to Run

- Start the containers:

    `docker-compose up -d`
    `docker exec -it iris-pygw-blueprint_iris_1 iris session IRIS`

- run the following code to test it

    `zn "PYTHON"`
    `set st = ##class(abc.python).connectToGateway("pogs",.GW)`
    `set person = ##class(%Net.Remote.Object).%New(GW,"PersonDemo.Person")`
    `write !,"Default values: ",person.displayPerson()`