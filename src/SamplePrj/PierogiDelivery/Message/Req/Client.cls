Class SamplePrj.PierogiDelivery.Message.Req.Client Extends Ens.Request
{

Property Name As %String;

Property Street As %String;

Property City As %String;

<Storage name="Default">
<Data name="ClientDefaultData">
<Subscript>"Client"</Subscript>
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>Street</Value>
</Value>
<Value name="3">
<Value>City</Value>
</Value>
</Data>
<DefaultData>ClientDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

