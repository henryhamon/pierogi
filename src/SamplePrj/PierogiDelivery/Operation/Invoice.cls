Class SamplePrj.PierogiDelivery.Operation.Invoice Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method GetTotal(pInput As SamplePrj.PierogiDelivery.Operation.Invoice.Req, Output pResponse As SamplePrj.PierogiDelivery.Operation.Invoice.Resp) As %Status
{
	Set tSC = $$$OK
	Try {
		Set pResponse = ##class(SamplePrj.PierogiDelivery.Operation.Invoice.Resp).%New(),
			pResponse.TotalPrice = pInput.Price * pInput.Quantity
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="SamplePrj.PierogiDelivery.Operation.Invoice.Req">
		<Method>GetTotal</Method>
	</MapItem>
</MapItems>
}

}

