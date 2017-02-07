Class Pierogi.core.Ensemble
{

ClassMethod RunTimeInfo(pTargetDispatchName As %String, Output pConfigName As %String, Output pClassName As %String) As %Status
{
	Set tSC = $$$OK
	Try {
		Set pConfigName = $get(^Ens.Runtime("DispatchName",pTargetDispatchName))
		Set pClassName =  $get(^Ens.Runtime("ConfigItem",pConfigName,"ClassName"))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}

