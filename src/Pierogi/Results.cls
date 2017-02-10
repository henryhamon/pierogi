Class Pierogi.Results Extends %SerialObject
{

Property Test As %Integer;

Property Pass As %Integer;

Property Fail As %Integer;

Property All As %ArrayOfDataTypes;

Property Status As %Status;

<Storage name="Default">
<Data name="ResultsState">
<Value name="1">
<Value>All</Value>
</Value>
<Value name="2">
<Value>Pass</Value>
</Value>
<Value name="3">
<Value>Fail</Value>
</Value>
<Value name="4">
<Value>Test</Value>
</Value>
<Value name="5">
<Value>Status</Value>
</Value>
</Data>
<State>ResultsState</State>
<StreamLocation>^Pierogi.ResultsS</StreamLocation>
<Type>%Library.CacheSerialState</Type>
</Storage>
}

