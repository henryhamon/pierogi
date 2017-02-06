Class SamplePrj.PierogiDelivery.Message.Req.Order Extends Ens.Request
{

Property ClientName As %String;

Property ClientStreet As %String;

Property ClientCity As %String;

Property Quantity As %Integer;

Property PierogiFlavor As %String;

<Storage name="Default">
<Data name="OrderDefaultData">
<Subscript>"Order"</Subscript>
<Value name="1">
<Value>ClientName</Value>
</Value>
<Value name="2">
<Value>ClientStreet</Value>
</Value>
<Value name="3">
<Value>ClientCity</Value>
</Value>
<Value name="4">
<Value>Quantity</Value>
</Value>
<Value name="5">
<Value>PierogiFlavor</Value>
</Value>
</Data>
<DefaultData>OrderDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

