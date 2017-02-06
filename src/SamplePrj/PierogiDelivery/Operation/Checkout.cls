Class SamplePrj.PierogiDelivery.Operation.Checkout Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method ProcessOrder(pInput As SamplePrj.PierogiDelivery.Operation.Checkout.Req, Output pResponse As SamplePrj.PierogiDelivery.Operation.Checkout.Resp) As %Status
{
	Set tSC = $$$OK, 
		pResponse = ##class(SamplePrj.PierogiDelivery.Operation.Checkout.Resp).%New()
		
	Try {
		Set tOrder = ##class(SamplePrj.PierogiDelivery.Data.Order).%New(), 
			tOrder.Quantity = pInput.Quantity, 
			tOrder.TotalPrice = pInput.TotalPrice,
			tOrder.OrderedAt = $ZDateTime($Horolog,3),
			tClient = ##class(SamplePrj.PierogiDelivery.Data.Clients).%OpenId(pInput.ClientId),
			tFlavor = ##class(SamplePrj.PierogiDelivery.Data.Flavors).%OpenId(pInput.FlavorId)
		
		$$$THROWONERROR(tSC, tClient.Orderes.Insert(tOrder))
		$$$THROWONERROR(tSC, tFlavor.Meals.Insert(tOrder))
		$$$THROWONERROR(tSC, tClient.%Save())
		$$$THROWONERROR(tSC, tFlavor.%Save())
		
		$$$THROWONERROR(tSC, tOrder.%Save())
		Set pResponse.OrderId = tOrder.%Id()
		
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Set pResponse.Status = tSC
	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="SamplePrj.PierogiDelivery.Operation.Checkout.Req">
		<Method>ProcessOrder</Method>
	</MapItem>
</MapItems>
}

}

