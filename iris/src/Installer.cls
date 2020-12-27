/// Installer for the container release of PythonGateway
Class abc.Installer
{

XData Install [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Var Name="pwd" Value="SYS"/> 
  <User Username="SuperUser" ChangePassword="0" PasswordVar="pwd" Roles="%All" Enabled="1"/>
  <Default Name="NAMESPACE" Value="PYTHON"/>
  <Default Name="DBNAME" Value="${NAMESPACE}"/>
  <Default Name="SOURCESPATH" Dir='#{$system.Util.GetEnviron("SRC_DIR")}' />
  <Default Name="RESOURCE" Value="%DB_${DBNAME}" /> 
  <Namespace Name="${NAMESPACE}" Ensemble="1" Code="${DBNAME}CODE" Data="${DBNAME}DATA" Create="yes">
      <Configuration>
      <Database Name="${DBNAME}CODE" Dir="${MGRDIR}${DBNAME}CODE" Create="yes" Resource="${RESOURCE}" />
      <Database Name="${DBNAME}DATA" Dir="${MGRDIR}${DBNAME}DATA" Create="yes" Resource="${RESOURCE}" InitialSize="10" />
    </Configuration>

    <Import File="${SOURCESPATH}iriscode" Recurse="1"/>
     
    <Log Level="1" Text="Enabling OS level Authentication"/>
    <Invoke Class="abc.Installer" Method="OSAuth" CheckStatus="true"/>
    
	<Log Level="1" Text="Creating and Starting Python Gateway"/>
    <Invoke Class="abc.Installer" Method="CreateGateway"/>

  </Namespace>
</Manifest>
}

ClassMethod Setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "Install")
}

ClassMethod CreateGateway() As %Status 
{
  set sc = ##class(abc.python).createGateway("pogs")
  quit:$$$ISERR(sc) sc
}

/// Enable OS Authentication
ClassMethod OSAuth() As %Status
{
	new $namespace
	set $namespace = "%SYS"
	set sc = ##Class(Security.System).Get($$$SystemSecurityName,.properties)
	quit:$$$ISERR(sc) sc
	
	set autheEnabled = properties("AutheEnabled")
	quit:'$data(autheEnabled) $$$ERROR($$$PropertyDoesNotExist, "AutheEnabled")
	set properties("AutheEnabled") = $ZBOOLEAN(+autheEnabled, $$$AutheOS, 7)
	set sc = ##Class(Security.System).Modify($$$SystemSecurityName, .properties) 
	
	quit sc
}

}
