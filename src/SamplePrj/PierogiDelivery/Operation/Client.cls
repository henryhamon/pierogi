Class SamplePrj.PierogiDelivery.Operation.Client Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter SETTINGS = "ReplyCodeActions,RetryInterval,AlertRetryGracePeriod:Alerting,FailureTimeout,QueueCountAlert:Alerting";

Method GetClientId(pInput As SamplePrj.PierogiDelivery.Operation.Client.Req, Output pResponse As SamplePrj.PierogiDelivery.Operation.Client.Resp) As %Status
{
	Set tSC = $$$OK
	$$$TRACE("GetClient")
	Try {
		$$$TRACE(pInput.Name)
		Set pResponse = ##class(SamplePrj.PierogiDelivery.Operation.Client.Resp).%New()
		
		Set tSql = "Select TOP 1 ID as Client FROM SamplePrj_PierogiDelivery_Data.Clients "_
			" WHERE Name %StartsWith ? AND Street Like ? AND City = ?",
			tStatement =  ##class(%SQL.Statement).%New()
		$$$THROWONERROR(tSC, tStatement.%Prepare(tSql))
		
		Set tRS = tStatement.execute(pInput.Name, pInput.Street, pInput.City)
		
		$$$THROWONERROR(tSC, tRS.%Next())
		Set pResponse.ClientId = tRS.%Get("Client")
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="SamplePrj.PierogiDelivery.Operation.Client.Req">
		<Method>GetClientId</Method>
	</MapItem>
</MapItems>
}

}

