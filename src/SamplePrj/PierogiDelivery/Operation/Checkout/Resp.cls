Class SamplePrj.PierogiDelivery.Operation.Checkout.Resp Extends Ens.Response
{

Property OrderId As %String;

Property Status As %Status;

<Storage name="Default">
<Data name="RespDefaultData">
<Subscript>"Resp"</Subscript>
<Value name="1">
<Value>Status</Value>
</Value>
<Value name="2">
<Value>OrderId</Value>
</Value>
</Data>
<DefaultData>RespDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

