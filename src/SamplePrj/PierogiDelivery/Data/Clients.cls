Class SamplePrj.PierogiDelivery.Data.Clients Extends (%Persistent, %Populate)
{

Property Name As %String;

Property Street As %String;

Property City As %String;

Relationship Orderes As SamplePrj.PierogiDelivery.Data.Order [ Cardinality = children, Inverse = Client ];

<Storage name="Default">
<Data name="ClientsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Street</Value>
</Value>
<Value name="4">
<Value>City</Value>
</Value>
</Data>
<DataLocation>^SamplePrj.Pierogi5322.ClientsD</DataLocation>
<DefaultData>ClientsDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^SamplePrj.Pierogi5322.ClientsD</IdLocation>
<IndexLocation>^SamplePrj.Pierogi5322.ClientsI</IndexLocation>
<Property name="%%CLASSNAME">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="City">
<Selectivity>14.2857%</Selectivity>
</Property>
<Property name="Name">
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="Street">
<Selectivity>10.0000%</Selectivity>
</Property>
<SequenceNumber>5</SequenceNumber>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SamplePrj.Pierogi5322.ClientsS</StreamLocation>
<Type>%Library.CacheStorage</Type>
</Storage>
}

