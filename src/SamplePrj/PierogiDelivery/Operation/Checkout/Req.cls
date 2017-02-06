Class SamplePrj.PierogiDelivery.Operation.Checkout.Req Extends Ens.Request
{

Property ClientId As %String;

Property FlavorId As %String;

Property Quantity As %Integer;

Property TotalPrice As %Numeric;

<Storage name="Default">
<Data name="ReqDefaultData">
<Subscript>"Req"</Subscript>
<Value name="1">
<Value>ClientId</Value>
</Value>
<Value name="2">
<Value>FlavorId</Value>
</Value>
<Value name="3">
<Value>Quantity</Value>
</Value>
<Value name="4">
<Value>TotalPrice</Value>
</Value>
</Data>
<DefaultData>ReqDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

