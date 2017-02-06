Class SamplePrj.PierogiDelivery.Message.Pierogi Extends Ens.Response
{

Property FlavorId As %String;

Property Price As %Numeric;

<Storage name="Default">
<Data name="PierogiDefaultData">
<Subscript>"Pierogi"</Subscript>
<Value name="1">
<Value>FlavorId</Value>
</Value>
<Value name="2">
<Value>Price</Value>
</Value>
</Data>
<DefaultData>PierogiDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

