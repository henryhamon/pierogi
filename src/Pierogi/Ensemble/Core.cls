Class Pierogi.Ensemble.Core
{

ClassMethod RunTimeInfo(pTargetDispatchName As %String, Output pConfigName As %String, Output pClassName As %String) As %Status
{
	Set tSC = $$$OK
	Try {
		Set pConfigName = "", pClassName = ""
		Set pConfigName = $get(^Ens.Runtime("DispatchName",pTargetDispatchName))
		Set:pConfigName'="" pClassName =  $get(^Ens.Runtime("ConfigItem",pConfigName,"ClassName"))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod IsAService(pClassName As %String) As %Boolean
{
	Set tResult = $$$NO
	Try {
		Set class = ##class(%Dictionary.ClassDefinition).%OpenId(pClassName)
		Set:($IsObject(class)&&(($Find(class.Super,"Ens.BusinessService")>0)||($Find(class.Super,"EnsLib.SOAP.Service")>0))) tResult = $$$YES
	} Catch tException {
		Set tResult = $$$NO
	}
	Quit tResult
}

ClassMethod Call(pTargetDispatchName As %String, pInput As %RegisteredObject, Output pOutput As %RegisteredObject = "") As %Status
{
	Set tSC = $$$OK, pOutput = ""
	Try {
		$$$THROWONERROR(tSC, ..RunTimeInfo(pTargetDispatchName, .pConfigName, .pClassname))
		Set:pClassname="" tSC = $$$ERROR(5002,pTargetDispatchName _ " Not Found")
		Throw:$$$ISERR(tSC)
		
		If ..IsAService(pClassname) {
			$$$THROWONERROR(tSC, ..CallWithBusinessService(pTargetDispatchName, pInput, .pOutput))
		} Else {
			$$$THROWONERROR(tSC, ..CallWithoutBusinessService(pTargetDispatchName, pInput, .pOutput))
		}
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod CallWithBusinessService(pTargetDispatchName As %String, pInput As %RegisteredObject, Output pOutput As %RegisteredObject = "") As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		
		$$$THROWONERROR(tSC, ##class(Ens.Director).CreateBusinessService(pTargetDispatchName,.tService))
		Do tService.ProcessInput(pInput,.pOutput)
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod CallWithoutBusinessService(pTargetDispatchName As %String, pInput As %RegisteredObject, Output pOutput As %RegisteredObject = "") As %Status [ Private ]
{
	Set tSC = $$$OK
	Try {
		$$$THROWONERROR(tSC, ..EnableComponent(pTargetDispatchName, .pEnabled))
		$$$THROWONERROR(tSC,  ##Class(EnsLib.Testing.Service).SendTestRequest(pTargetDispatchName, pInput, .pOutput, .tSessionId, $$$YES))
		Set ^CacheTemp.EnsRuntimeAppData($Namespace,"EnsLib.Testing.Service",tSessionId,"start") = $ZDatetime($ztimestamp,3,,3)
		If pEnabled=0 {
			$$$THROWONERROR(tSC, ..DisableComponent(pTargetDispatchName, .pEnabled))
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod IsProductionOn() As %Boolean
{
	Quit ##class(Ens.Director).IsProductionRunning(.name)
}

ClassMethod EnableComponent(pTargetDispatchName As %String, Output pEnabled) As %Status
{
	Set tSC = $$$OK
	Try {
		Set pEnabled = ##class(Ens.Director).IsItemEnabled(pTargetDispatchName, .tSC)
		Throw:$$$ISERR(tSC)
		If pEnabled=0 {
			$$$THROWONERROR(tSC, ##class(Ens.Director).EnableConfigItem(pTargetDispatchName, 1))
		}
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod DisableComponent(pTargetDispatchName As %String) As %Status
{
	Set tSC = $$$OK
	Try {
		$$$THROWONERROR(tSC, ##class(Ens.Director).EnableConfigItem(pTargetDispatchName, 0))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

