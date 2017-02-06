Class SamplePrj.PierogiDelivery.Process.Client Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As SamplePrj.PierogiDelivery.Process.Client.Req, Output pResponse As SamplePrj.PierogiDelivery.Operation.Client.Resp) As %Status
{
	Set tSC = $$$OK
	Try {
		Set tClient = ##class(SamplePrj.PierogiDelivery.Operation.Client.Req).%New(),
			tClient.Name = pRequest.Name, 
			tClient.City = pRequest.City, 
			tClient.Street = pRequest.Street,
			pResponse = ##class(SamplePrj.PierogiDelivery.Operation.Client.Resp).%New()
		$$$THROWONERROR(tSC, tClient.%Save())
		$$$THROWONERROR(tSC, ..SendRequestSync("boClient", tClient, .pResponse))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

<Storage name="Default">
<Type>%Library.CacheStorage</Type>
</Storage>
}

