Class SamplePrj.PierogiDelivery.Message.Resp.Invoice Extends Ens.Response
{

Property TotalPrice As %Numeric;

<Storage name="Default">
<Data name="InvoiceDefaultData">
<Subscript>"Invoice"</Subscript>
<Value name="1">
<Value>TotalPrice</Value>
</Value>
</Data>
<DefaultData>InvoiceDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

