Class SamplePrj.PierogiDelivery.Message.Resp.Client Extends Ens.Response
{

Property ClientId As %String;

<Storage name="Default">
<Data name="ClientDefaultData">
<Subscript>"Client"</Subscript>
<Value name="1">
<Value>ClientId</Value>
</Value>
</Data>
<DefaultData>ClientDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

