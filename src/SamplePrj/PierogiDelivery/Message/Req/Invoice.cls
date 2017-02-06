Class SamplePrj.PierogiDelivery.Message.Req.Invoice Extends Ens.Request
{

Property Flavor As %String;

<Storage name="Default">
<Data name="InvoiceDefaultData">
<Subscript>"Invoice"</Subscript>
<Value name="1">
<Value>Flavor</Value>
</Value>
</Data>
<DefaultData>InvoiceDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

