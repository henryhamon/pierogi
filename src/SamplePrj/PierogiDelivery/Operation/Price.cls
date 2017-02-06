Class SamplePrj.PierogiDelivery.Operation.Price Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method GetPrice(pInput As SamplePrj.PierogiDelivery.Operation.Price.Req, Output pResponse As SamplePrj.PierogiDelivery.Operation.Price.Resp) As %Status
{
	Set tSC = $$$OK
	Try {
			Set tFlavor = ##class(SamplePrj.PierogiDelivery.Data.Flavors).FindNameOpen(pInput.Flavor),
				pResponse = ##class(SamplePrj.PierogiDelivery.Operation.Price.Resp).%New(),
				pResponse.Price = tFlavor.Price,
				pResponse.FlavorId = tFlavor.%Id()
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="SamplePrj.PierogiDelivery.Operation.Price.Req">
		<Method>GetPrice</Method>
	</MapItem>
</MapItems>
}

}

