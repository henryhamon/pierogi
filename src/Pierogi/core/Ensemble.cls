Class Pierogi.core.Ensemble
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
		Set:($IsObject(class)&&($Find(class.Super,"Ens.BusinessService")>0)) tResult = $$$YES
	} Catch tException {
		Set tResult = $$$NO
	}
	Quit tResult
}

}

