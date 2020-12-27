class abc.python extends %RegisteredObject {

    ClassMethod connectToGateway(Name As %String, ByRef GW As %Net.Remote.Gateway) As %Status {
        set GW = ##class(%Net.Remote.Gateway).%New()
        set st = ##class(%Net.Remote.Service).OpenGateway(Name,.OG)
        quit:$$$ISERR(st) st

        set st = GW.%Connect(OG.Server, OG.Port)
        quit:$$$ISERR(st) st
        set pathList = ##class(%ListOfDataTypes).%New()
        
        set st = pathList.Insert("/home/appuser/py/Company.py")
        set st = pathList.Insert("/home/appuser/py/PersonDemo.py")
        set st = GW.%AddToCurrentClassPath(pathList)
        quit:$$$ISERR(st) st

        QUIT $$$OK
    }



    ClassMethod createGateway(Name As %String) As %Status { 
        set OG =  ##class(%Net.Remote.ObjectGateway).%New()

        // Properties used in all server definitions
        set OG.Type = "3"   // Defines a Python server
        set OG.Name  = Name
        set OG.Server  = "pogs"
        set OG.Port  = "57575" // port number must be unique

        //Location of the Python Executable Path. It is used to find the target Python interpreter and get the command to start the Gateway.
        // Note: If there is a default Python interpreter on the machine that is usable without the need to specify its location, this setting may be left blank.
        // (This property applies only to Python Gateways.)
        set OG.PythonPath=""

        //Optional Python options to be passed to the Python interpreter to include when assembling the command to start the Gateway.
        //(This property applies only to Python Gateways.)
        set OG.PyOptions=""

        //Fully qualified name of a file to log all communication between InterSystems IRIS and the Gateway Server. 
        // Usually this setting should be left blank, and used only for trouble-shooting.
        set OG.LogFile=""

        //Number of seconds to wait for a response during initialization of the Gateway Server.
        set OG.InitializationTimeout=5

        // A non-zero value for this property enables heartbeat, which is periodic communication with the Gateway Server to check if it's active. The default is 10 seconds. When enabled, the minimum value is 5 seconds and the maximum value is 3600 seconds or 1 hour.
        // When heartbeat is disabled the monitor process won't be started and the related settings are ignored.
        set OG.HeartbeatInterval=3600

        // Number of seconds to wait for a connection to be established with the Gateway Server.
        set OG.ConnectionTimeout=5
        
        //On 64-bit platforms, indicates if the Object Gateway server is to be executed as 32-bit (default) or 64-bit.
        set OG.Exec64=1

        set sc = OG.%Save()
        Quit sc
    }

}