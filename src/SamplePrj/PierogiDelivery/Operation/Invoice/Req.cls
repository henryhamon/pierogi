Class SamplePrj.PierogiDelivery.Operation.Invoice.Req Extends Ens.Request
{

Property Quantity As %Integer;

Property Price As %Numeric;

<Storage name="Default">
<Data name="ReqDefaultData">
<Subscript>"Req"</Subscript>
<Value name="1">
<Value>Quantity</Value>
</Value>
<Value name="2">
<Value>Price</Value>
</Value>
</Data>
<DefaultData>ReqDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

