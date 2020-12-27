# IRIS Python Gateway Blueprint

This repository is a mini blueprint of how you can communicate with Python using Python Gateway.

    docker-compose up -d
    docker exec -it iris-pygw-blueprint_iris_1 iris session IRIS

    zn "PYTHON"
    set st = ##class(abc.python).connectToGateway("pogs",.GW)
    set person = ##class(%Net.Remote.Object).%New(GW,"PersonDemo.Person")
    write !,"Default values: ",person.displayPerson()