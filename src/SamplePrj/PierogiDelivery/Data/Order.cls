Class SamplePrj.PierogiDelivery.Data.Order Extends %Persistent
{

Property OrderedAt As %DateTime;

Property Quantity As %Integer;

Property TotalPrice As %Numeric;

Relationship Client As SamplePrj.PierogiDelivery.Data.Clients [ Cardinality = parent, Inverse = Orderes ];

Relationship Pierogis As SamplePrj.PierogiDelivery.Data.Flavors [ Cardinality = one, Inverse = Meals ];

Index PierogisIndex On Pierogis;

<Storage name="Default">
<Data name="OrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Pierogis</Value>
</Value>
<Value name="3">
<Value>OrderedAt</Value>
</Value>
<Value name="4">
<Value>Quantity</Value>
</Value>
<Value name="5">
<Value>TotalPrice</Value>
</Value>
</Data>
<DataLocation>{%%PARENT}("Orderes")</DataLocation>
<DefaultData>OrderDefaultData</DefaultData>
<IdLocation>^SamplePrj.Pierogi5322.ClientsC("Orderes")</IdLocation>
<IndexLocation>^SamplePrj.PierogiDe5322.OrderI</IndexLocation>
<SequenceNumber>4</SequenceNumber>
<StreamLocation>^SamplePrj.PierogiDe5322.OrderS</StreamLocation>
<Type>%Library.CacheStorage</Type>
</Storage>
}

